import 'package:notify/shared/domin/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  UserModel? getUser();
  Future<void> clearUser();
}