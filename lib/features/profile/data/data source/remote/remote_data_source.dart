import 'package:notify/features/group/domin/usecases/add_supervisor.dart';
import 'package:notify/features/group/domin/usecases/create_group.dart';
import 'package:notify/features/group/domin/usecases/join_group.dart';
import 'package:notify/features/group/domin/usecases/leave_group.dart';
import 'package:notify/features/profile/domin/usecases/get_user_info.dart';
import 'package:notify/shared/domin/entities/user_model.dart';

abstract class ProfileRemoteDataSource {
  // fetch user data
  Future<UserModel> getUserInfo(GetUserInfoParams params);
  
}