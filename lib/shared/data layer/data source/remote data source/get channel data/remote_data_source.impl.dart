import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/shared/data%20layer/data%20source/remote%20data%20source/get%20channel%20data/remote_data_source.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/domin/usecases/get_channel_data_using_id.dart';

class GetChannelDataRemoteDataSourceImpl
    implements GetChannelDataRemoteDataSource {
  @override
  Future<Channel> getChannelData(GetChannelInfoParams params) async {
    try {
      var query = await FirebaseFirestore.instance
          .collection('channels')
          .doc(params.channelId)
          .get();

      Channel channel = Channel.fromFirebase(query);

      return channel;
    } on FirebaseException {
      throw const FirebaseErrorFailure("Error getting channel data");
    } catch (e) {
      rethrow;
    }
  }
}
