import 'package:notify/shared/domin/usecases/get_user_info.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/domin/entities/user_model.dart';

abstract class HomeRemoteDataSource{
  Future<List<Channel>> getBiggestChannels();
  Future<UserModel> getUserData(GetUserInfoParams params);
}