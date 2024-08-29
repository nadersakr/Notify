import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/features/auth/data/data_source/remote_data_source.dart';
import 'package:notify/features/auth/domin/entities/user_model.dart';
import 'package:notify/features/auth/domin/usecases/login.dart';
import 'package:notify/features/auth/domin/usecases/signup.dart';
import 'package:notify/shared/data%20layer/remote%20data%20source/firebase_services.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();
  @override
  Future<UserModel> login(LoginParams params) async {
    // return await authServices.login(params);
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signup(SignUpParams params) async {
    try {
      var response = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      if (response.user == null) {
        throw const ServerFailure("Server Failure", 402);
      }
      await FirebaseServices.saveUserData(params.userName, params.firstName,
          params.lastName, response.user!.uid);
      return UserModel(
        email: "nadersakr@gmail.com",
        id: "123",
        firstName: "Nader",
        lastName: "Sakr",
        chanalsId: [],
        username: 'nadersakr',
      );
    } catch (e) {
      throw const ServerFailure("Server Failure", 402);
    }
  }
}


