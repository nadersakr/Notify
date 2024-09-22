import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/delete_channel.dart';
import 'package:notify/shared/data%20layer/data%20source/firebase_messaging.dart';
import 'package:notify/features/channel%20manipulation/data/data%20source/remote/remote_data_source.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/add_supervisor.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/create_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/join_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/leave_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/send_notification.dart';

class ChannelRemoteDataSourceImpl extends ChannelRemoteDataSource {
  @override
  Future<void> addSupervisorChannel(AddSupervisorParams params) {
    throw UnimplementedError();
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
        'membersId': params.channel.membersId,
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
        throw const FirebaseFailure("User is already a member of the channel");
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
    } on FirebaseFailure catch (e) {
      throw FirebaseFailure(e.errorMessage);
    } catch (e) {
      throw UnknowFailure("Unknown Failure ${e.toString()}");
    }
  }

  @override
  Future<void> leaveChannel(LeaveChannelParams params) async {
    try {
      // check if the user is a member of the channel
      final bool isUserMember = await FirebaseFirestore.instance
          .collection('channels')
          .doc(params.channel.id)
          .get()
          .then((value) {
        final members = value.data()!['membersId'] as List<dynamic>;
        return members.contains(params.leaverId);
      });
      if (!isUserMember) {
        throw const FirebaseFailure("User is not a member of the channel");
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

      // check if the user is a supervisor of the channel
      final bool isUserSupervisor = await FirebaseFirestore.instance
          .collection('channels')
          .doc(params.channel.id)
          .get()
          .then((value) {
        final supervisors = value.data()!['supervisorsId'] as List<dynamic>;
        return supervisors.contains(params.leaverId);
      });
      print(isUserSupervisor);
      // if (isUserSupervisor) {
      //   await FirebaseFirestore.instance
      //       .collection('channels')
      //       .doc(params.channel.id)
      //       .update({
      //     'supervisorsId': FieldValue.arrayRemove([params.leaverId]),
      //   });

      //   await FirebaseFirestore.instance
      //       .collection('users')
      //       .doc(params.leaverId)
      //       .update({
      //     'ownedChannels': FieldValue.arrayRemove([params.channel.id]),
      //   });

      //   // check if the channel has no supervisors
      //   final supervisorsCount = await FirebaseFirestore.instance
      //       .collection('channels')
      //       .doc(params.channel.id)
      //       .get()
      //       .then((value) {
      //     final supervisors = value.data()!['supervisorsId'] as List<dynamic>;
      //     return supervisors.length;
      //   });
      //   if (supervisorsCount == 0) {
      //     await FirebaseFirestore.instance
      //         .collection('channels')
      //         .doc(params.channel.id)
      //         .delete();
      //     final users = await FirebaseFirestore.instance
      //         .collection('users')
      //         .where('joinedChannels', arrayContains: params.channel.id)
      //         .get();
      //     for (final user in users.docs) {
      //       await user.reference.update({
      //         'joinedChannels': FieldValue.arrayRemove([params.channel.id]),
      //       });
      //     }
      //   }
      //   // delete channel from all users joined channels
      // }
    } on FirebaseFailure catch (e) {
      throw FirebaseFailure(e.errorMessage);
    } catch (e) {
      throw UnknowFailure("Unknown Failure ${e.toString()}");
    }
  }

  @override
  Future<void> sendNotification(SendNotificationParams params) async {
    try {
      print('Sending notification to channel: ${params.channel.id}');
      // Ensure notifications are set up
      await FirebaseMessagingService().setupNotifications();
      // Get the Firestore collection for notifications

      print("Notification sending");
      // Get the Firestore collection for channels
      final channelCollection =
          FirebaseFirestore.instance.collection('channels');

      // Reference the specific channel document
      final channelDoc = channelCollection.doc(params.channel.id);

      // Update the document to include the new notification
      await channelDoc.update({
        'notifications': FieldValue.arrayUnion([params.notification]),
      });
      print("Notification sent successfully");
    } catch (e) {
      rethrow;
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
