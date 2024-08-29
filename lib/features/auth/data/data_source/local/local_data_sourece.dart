import 'package:notify/features/auth/domin/entities/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  UserModel getUser();
}