import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notify/features/search/data/data%20source/remote/remote_data_source.dart';
import 'package:notify/features/search/domin/usecases/search_for_channel.dart';
import 'package:notify/features/search/domin/usecases/search_for_user.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/domin/entities/user_model.dart';

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  @override
  // Future<List<Channel>> searchForChannel(SearchForChannelParams params) async {
  //   final result = await FirebaseFirestore.instance
  //       .collection('channels')
  //       .where('name', isGreaterThanOrEqualTo: params.query)
  //       .where('name',
  //           isLessThanOrEqualTo: '${params.query}\uf8ff') // For partial search
  //       .get();
  //   List<Channel> channels = result.docs
  //       .map((e) => Channel.fromFirebase(e))
  //       .toList();

  //   return channels;
  // }

//  this function can't use for the large data because it fetch all documents
//  and then filter on client side
//  so we can use the below function to filter on server side
//  and then fetch the data
//  this function is optimizer than the above function, the above function is also correct but is more time consuming
  Future<List<Channel>> searchForChannel(SearchForChannelParams params) async {
    final result = await FirebaseFirestore.instance
        .collection('channels')
        .where('isPrivate', isEqualTo: false)
        .get(); // Fetch all documents

    List<Channel> channels = result.docs
        .map((e) => Channel.fromFirebase(e))
        .where((channel) => channel.title
            .toLowerCase()
            .contains(params.query.toLowerCase())) // Filter on client side
        .toList();

    return channels;
  }

  @override
  Future<List<UserModel>> searchForUser(SearchForUserParams params) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .get(); // Fetch all documents

    List<UserModel> users = result.docs
        .map((e) => UserModel.fromFirebase(e,id: e.id))
        .where((channel) => channel.fullName
            .toLowerCase()
            .contains(params.query.toLowerCase())) // Filter on client side
        .toList();

    return users;
  }
}
