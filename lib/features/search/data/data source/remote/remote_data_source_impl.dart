import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notify/features/search/data/data%20source/remote/remote_data_source.dart';
import 'package:notify/features/search/domin/usecases/search.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  @override
  Future<List<Channel>> searchForChannel(SearchForChannelParams params) async {
    final result = await FirebaseFirestore.instance
        .collection('channels')
        .where('name', isGreaterThanOrEqualTo: params.query)
        .where('name',
            isLessThanOrEqualTo: '${params.query}\uf8ff') // For partial search
        .get();
    List<Channel> channels = result.docs
        .map((e) => Channel.fromFirebase(e))
        .toList();

    
    return channels;
  }
}
