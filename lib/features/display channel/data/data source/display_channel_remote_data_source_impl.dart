import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notify/features/display%20channel/data/data%20source/display_channel_remote_data_source.dart';
import 'package:notify/features/display%20channel/domin/usecases/load_channel_data.dart';
import 'package:notify/shared/domin/models/channel_model.dart';

class DisplayChannelRemoteDataSourceImpl
    implements DisplayChannelRemoteDataSource {
  @override
  Future<Channel> getChannelData(LoadChannelDataParams params) async {
    try {
      final response = await FirebaseFirestore.instance
          .collection('channels')
          .doc(params.channelId)
          .get();
      return Channel.fromFirebase(response);
    } catch (e) {
      throw Exception(e);
    }
  }
}
