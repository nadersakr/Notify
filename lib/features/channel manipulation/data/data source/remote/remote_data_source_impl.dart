import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notify/features/channel%20manipulation/data/data%20source/remote/remote_data_source.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/add_supervisor.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/create_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/join_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/leave_channel.dart';

class ChannelRemoteDataSourceImpl extends ChannelRemoteDataSource {
  @override
  Future<void> addSupervisorChannel(AddSupervisorParams params) {
    
    throw UnimplementedError();
  }

  @override
  Future<void> createChannel(CreateChannelParams params) async {
    final channelCollection = FirebaseFirestore.instance.collection('channels');
    final userCollection = FirebaseFirestore.instance.collection('users');

    // Create the channel document
    final channelDoc = channelCollection.doc();
    await channelDoc.set({
      'id': params.channel.id,
      'name': params.channel.title,
      'description': params.channel.describtion,
      'imageUrl': params.channel.imageUrl,
      'color': params.channel.hexColor,
      'isPrivate':params.channel.isPrivate,
      'createdAt': FieldValue.serverTimestamp(),
      'ownerId': params.channel.creatorId,
    });

    // Add the channel ID to the user's list of owned channels
    final userDoc = userCollection.doc(params.channel.creatorId);
    await userDoc.update({
      'ownedChannels': FieldValue.arrayUnion([channelDoc.id]),
    });
    
  }

  @override
  Future<void> joinChannel(JoinChannelParams params) {
    
    throw UnimplementedError();
  }

  @override
  Future<void> leaveChannel(LeaveChannelParams params) {
    throw UnimplementedError();
  }
}