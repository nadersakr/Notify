import 'package:notify/shared/domin/usecases/get_user_info.dart';
import 'package:notify/shared/domin/models/user_model.dart';

abstract class ProfileRemoteDataSource {
  // fetch user data
  Future<UserModel> getUserInfo(GetUserInfoParams params);
  
}