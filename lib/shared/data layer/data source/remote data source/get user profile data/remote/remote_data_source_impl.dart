import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notify/features/profile/data/data%20source/remote/remote_data_source.dart';
import 'package:notify/shared/domin/entities/user_model.dart';
import 'package:notify/shared/domin/usecases/get_user_info.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<UserModel> getUserInfo(GetUserInfoParams params) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(params.userId)
        .get();
    
    return UserModel.fromFirebase(querySnapshot, id: params.userId);
  }
}