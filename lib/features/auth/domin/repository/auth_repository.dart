import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/shared/domin/entities/user_model.dart';
import 'package:notify/features/auth/domin/usecases/login.dart';
import 'package:notify/features/auth/domin/usecases/signup.dart';
abstract class AuthRepository {

  Future<Either<Failure,UserModel>> login(LoginParams params);
  Future<Either<Failure,UserModel>> signup(SignUpParams params);
  Future<Either<Failure,UserModel>> signinWithGoogle();
}
