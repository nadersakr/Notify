import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/delete_channel.dart';
import 'package:notify/features/channel%20manipulation/data/data%20source/remote/remote_data_source.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/add_supervisor.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/create_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/join_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/leave_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/send_notification.dart';
import 'package:notify/core/utils/services/firebase%20services/notification%20services/notification_base_class.dart';

class ChannelRemoteDataSourceImpl extends ChannelRemoteDataSource {
  final NotificationService notificationService;
  ChannelRemoteDataSourceImpl({required this.notificationService});

  @override
  Future<void> addSupervisorChannel(AddSupervisorParams params) async {
    try {
      // check if the user is already a supervisor of the channel
      final bool isUserSupervisor = await FirebaseFirestore.instance
          .collection('channels')
          .doc(params.channelId)
          .get()
          .then((value) {
        final supervisors = value.data()!['supervisorsId'] as List<dynamic>;
        return supervisors.contains(params.supervisorId);
      });
      if (isUserSupervisor) {
        throw const FirebaseErrorFailure(
            "User is already a supervisor of the channel");
      }
      await FirebaseFirestore.instance
          .collection('channels')
          .doc(params.channelId)
          .update({
        'supervisorsId': FieldValue.arrayUnion([params.supervisorId]),
        'membersCount': FieldValue.increment(1),
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(params.supervisorId)
          .update({
        'ownedChannels': FieldValue.arrayUnion([params.channelId]),
      });

      // also I need to check if the user is a member of the channel
      final bool isUserMember = await FirebaseFirestore.instance
          .collection('channels')
          .doc(params.channelId)
          .get()
          .then((value) {
        final members = value.data()!['membersId'] as List<dynamic>;
        return members.contains(params.supervisorId);
      });
      if (isUserMember) {
        await FirebaseFirestore.instance
            .collection('channels')
            .doc(params.channelId)
            .update({
          'membersId': FieldValue.arrayRemove([params.supervisorId]),
          'membersCount': FieldValue.increment(-1),
        });

        await FirebaseFirestore.instance
            .collection('users')
            .doc(params.supervisorId)
            .update({
          'joinedChannels': FieldValue.arrayRemove([params.channelId]),
        });
      }
    } on FirebaseErrorFailure catch (e) {
      throw FirebaseErrorFailure(e.errorMessage);
    } catch (e) {
      throw UnknowFailure("Unknown Failure ${e.toString()}");
    }
  }

  @override
  Future<void> createChannel(CreateChannelParams params) async {
    try {
      final channelCollection =
          FirebaseFirestore.instance.collection('channels');
      final userCollection = FirebaseFirestore.instance.collection('users');

      // Create the channel document
      final channelDoc = channelCollection.doc(params.channel.id);
      await channelDoc.set({
        'id': params.channel.id,
        'name': params.channel.title,
        'description': params.channel.description,
        'imageUrl': params.channel.imageUrl,
        'color': params.channel.hexColor,
        'isPrivate': params.channel.isPrivate,
        'createdAt': FieldValue.serverTimestamp(),
        'ownerId': params.channel.creatorId,
        'membersCount': params.channel.membersCount,
        'membersId': [],
        'supervisorsId': params.channel.supervisorsId,
        'notifications': [],
      });

      // Add the channel ID to the user's list of owned channels
      final userDoc = userCollection.doc(params.channel.creatorId);
      await userDoc.update({
        'ownedChannels': FieldValue.arrayUnion([channelDoc.id]),
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> joinChannel(JoinChannelParams params) async {
    try {
      // check if the user is already a member of the channel
      final bool isUserMember = await FirebaseFirestore.instance
          .collection('channels')
          .doc(params.channel.id)
          .get()
          .then((value) {
        final members = value.data()!['membersId'] as List<dynamic>;
        return members.contains(params.joinerId);
      });
      if (isUserMember) {
        throw const FirebaseErrorFailure(
            "User is already a member of the channel");
      }
      await FirebaseFirestore.instance
          .collection('channels')
          .doc(params.channel.id)
          .update({
        'membersId': FieldValue.arrayUnion([params.joinerId]),
        'membersCount': FieldValue.increment(1),
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(params.joinerId)
          .update({
        'joinedChannels': FieldValue.arrayUnion([params.channel.id]),
      });
      await sl<NotificationService>().subscribeToTopic(params.channel.id);
    } on FirebaseErrorFailure catch (e) {
      throw FirebaseErrorFailure(e.errorMessage);
    } catch (e) {
      throw UnknowFailure("Unknown Failure ${e.toString()}");
    }
  }

  @override
  Future<void> leaveChannel(LeaveChannelParams params) async {
    // check if the user is a member of the channel
    try {
      final bool isSupervisor =
          params.channel.supervisorsId.contains(params.leaverId);
      if (isSupervisor) {
        if (params.channel.supervisorsId.length == 1) {
          DeleteChannelParams deleteChannelParams =
              DeleteChannelParams(channel: params.channel);
          deleteChannel(deleteChannelParams);
          await sl<NotificationService>()
              .unsubscribeFromTopic(params.channel.id);

          return;
        }
        await FirebaseFirestore.instance
            .collection('channels')
            .doc(params.channel.id)
            .update({
          'supervisorsId': FieldValue.arrayRemove([params.leaverId]),
          'membersCount': FieldValue.increment(-1),
        });

        await FirebaseFirestore.instance
            .collection('users')
            .doc(params.leaverId)
            .update({
          'ownedChannels': FieldValue.arrayRemove([params.channel.id]),
        });
        await sl<NotificationService>().unsubscribeFromTopic(params.channel.id);

        return;
      }
      final bool isUserMember =
          params.channel.membersId.contains(params.leaverId);
      if (!isUserMember) {
        throw const FirebaseErrorFailure("User is not a member of the channel");
      }
      await FirebaseFirestore.instance
          .collection('channels')
          .doc(params.channel.id)
          .update({
        'membersId': FieldValue.arrayRemove([params.leaverId]),
        'membersCount': FieldValue.increment(-1),
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(params.leaverId)
          .update({
        'joinedChannels': FieldValue.arrayRemove([params.channel.id]),
      });
      await sl<NotificationService>().unsubscribeFromTopic(params.channel.id);
    } on FirebaseErrorFailure catch (e) {
      throw FirebaseErrorFailure(e.errorMessage);
    } catch (e) {
      throw UnknowFailure("Unknown Failure ${e.toString()}");
    }
  }

  @override
  Future<void> sendNotification(SendNotificationParams params) async {

      notificationService.sendFCMTopicMessage(
        topic: params.channel.id,
        title: params.channel.title,
        body: params.notification.message,
        imageUrl: params.channel.imageUrl,
      );
      
      // I need to save the notification in the notifications collection 
      await FirebaseFirestore.instance.collection("notifications").doc(params.notification.id).set({
        'message': params.notification.message,
        'timestamp': FieldValue.serverTimestamp(),
        'channelId': params.channel.id,
      });
      // also and the notification to the channel notifications list
      await FirebaseFirestore.instance.collection('channels').doc(params.channel.id).update({
        'notifications': FieldValue.arrayUnion([params.notification.id]),
      });

      // also I need to save the notification in the channel's users notifications list
      final List<String> users = params.channel.membersId;
      for (final user in users) {
        await FirebaseFirestore.instance.collection('users').doc(user).update({
          'notifications': FieldValue.arrayUnion([params.notification.id]),
        });
      }



  }

  @override
  Future<void> deleteChannel(DeleteChannelParams params) async {
    try {
      // remove the channel from all users owned channels
      final List<String> supervisors = params.channel.supervisorsId;
      for (final supervisor in supervisors) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(supervisor)
            .update({
          'ownedChannels': FieldValue.arrayRemove([params.channel.id]),
        });
      }
      final List<String> users = params.channel.membersId;
      for (final user in users) {
        await FirebaseFirestore.instance.collection('users').doc(user).update({
          'joinedChannels': FieldValue.arrayRemove([params.channel.id]),
        });
      }
      await FirebaseFirestore.instance
          .collection('channels')
          .doc(params.channel.id)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
}
