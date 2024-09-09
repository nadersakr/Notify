import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notify/core/network/error/exceptions.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/features/auth/data/data_source/remote/remote_data_source.dart';
import 'package:notify/shared/domin/entities/user_model.dart';
import 'package:notify/features/auth/domin/usecases/login.dart';
import 'package:notify/features/auth/domin/usecases/signup.dart';
import 'package:notify/features/auth/presentation/controllers/signup%20view%20model/signup_view_model.dart';
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
        throw FirebaseAuthFailure(SignupViewModle.userNotCreated);
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
          throw FirebaseAuthFailure(SignupViewModle.weakPassword);
        case "email-already-in-use":
          throw FirebaseAuthFailure(SignupViewModle.emailAlreadyInUse);
        case "invalid-email":
          throw FirebaseAuthFailure(SignupViewModle.invalidEmail);
        default:
          throw FirebaseAuthFailure(SignupViewModle.defaultError);
      }
    } on CacheException catch (e) {
      throw CacheFailure(e.message);
    }
  }

  @override
  Future<UserModel> signinWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user == null) {
        throw FirebaseAuthException(code: 'user-not-found');
      }

      // Perform additional operations with the user data

      return UserModel(
        email: user.email ?? "user@example.com",
        id: user.uid,
        firstName: user.displayName?.split(' ')[0] ?? '',
        lastName: user.displayName?.split(' ')[1] ?? '',
        chanalsId: [],
        username: '',
      );
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth exceptions
      switch (e.code) {
        case 'user-not-found':
          throw FirebaseAuthFailure(SignupViewModle.userNotFound);
        // Handle other specific exceptions if needed
        default:
          throw FirebaseAuthFailure(SignupViewModle.defaultError);
      }
    } on Exception catch (e) {
      // Handle generic exceptions
      // print(e.toString());
      throw FirebaseAuthFailure(e.toString());
    }
  }
}
