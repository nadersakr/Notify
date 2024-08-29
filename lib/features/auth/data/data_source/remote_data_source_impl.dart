import 'package:firebase_auth/firebase_auth.dart';
import 'package:notify/core/network/error/exceptions.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/features/auth/data/data_source/remote_data_source.dart';
import 'package:notify/features/auth/domin/entities/user_model.dart';
import 'package:notify/features/auth/domin/usecases/login.dart';
import 'package:notify/features/auth/domin/usecases/signup.dart';
import 'package:notify/features/auth/presentation/screens/view%20model/signup%20view%20model/signup_view_model.dart';
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
      await FirebaseServices.searchUsername(params.userName);
      var response = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      if (response.user == null) {
        throw FirebaseAUthFailure(SignupViewModle.userNotCreated);
      }
      await FirebaseServices.saveUserData(params.userName, params.firstName,
          params.lastName, response.user!.uid);
      return UserModel(
        email: params.email,
        id: response.user!.uid,
        firstName: params.firstName,
        lastName: params.lastName,
        chanalsId: [],
        username: params.userName,
      );
    } on FirebaseAuthException catch (e) {
      //  weak-password
      // email-already-in-use
      // invalid-email
      switch (e.code) {
        case "weak-password":
          throw FirebaseAUthFailure(SignupViewModle.weakPassword);
        case "email-already-in-use":
          throw FirebaseAUthFailure(SignupViewModle.emailAlreadyInUse);
        case "invalid-email":
          throw FirebaseAUthFailure(SignupViewModle.invalidEmail);
        default:
          throw FirebaseAUthFailure(SignupViewModle.defaultError);
      }
    } on CacheException catch (e) {
      throw CacheFailure(e.message);
    }
  }
}
