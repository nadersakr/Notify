import 'package:notify/features/auth/domin/entities/user_model.dart';
import 'package:notify/features/auth/domin/usecases/login.dart';
import 'package:notify/features/auth/domin/usecases/signup.dart';

abstract class AuthRemoteDataSource {
  // login user
  Future<UserModel> login(LoginParams params);
  Future<UserModel> signup(SignUpParams params);
}