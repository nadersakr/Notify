import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notify/features/channel/data/data%20source/remote/remote_data_source.dart';
import 'package:notify/features/channel/domin/usecases/add_supervisor.dart';
import 'package:notify/features/channel/domin/usecases/create_channel.dart';
import 'package:notify/features/channel/domin/usecases/join_channel.dart';
import 'package:notify/features/channel/domin/usecases/leave_channel.dart';

class ChannelRemoteDataSourceImpl extends ChannelRemoteDataSource {
  @override
  Future<void> addSupervisorChannel(AddSupervisorParams params) {
    // TODO: implement addSupervisorChannel
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
      'ownerId': params.creator,
    });

    // Add the channel ID to the user's list of owned channels
    final userDoc = userCollection.doc(params.creator);
    await userDoc.update({
      'ownedChannels': FieldValue.arrayUnion([channelDoc.id]),
    });
    
  }

  @override
  Future<void> joinChannel(JoinChannelParams params) {
    // TODO: implement joinChannel
    throw UnimplementedError();
  }

  @override
  Future<void> leaveChannel(LeaveChannelParams params) {
    // TODO: implement leaveChannel
    throw UnimplementedError();
  }
}