import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notify/features/channel%20manipulation/data/data%20source/remote/firebase_messaging.dart';
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
        'membersCount': 1,
        'membersId': [params.channel.creatorId],
        'superVisorsId': [params.channel.creatorId],
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
  Future<void> joinChannel(JoinChannelParams params) {
    throw UnimplementedError();
  }

  @override
  Future<void> leaveChannel(LeaveChannelParams params) {
    throw UnimplementedError();
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
}
