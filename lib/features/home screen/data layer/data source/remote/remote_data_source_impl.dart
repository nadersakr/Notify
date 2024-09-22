import 'package:notify/features/home%20screen/data%20layer/data%20source/remote/remote_data_source.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<Channel>> getBiggestChannels() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('channels')
        .orderBy('membersCount', descending: true)
        .limit(4)
        .get();
    return querySnapshot.docs.map((doc) => Channel.fromFirebase(doc)).toList();
  }
}
