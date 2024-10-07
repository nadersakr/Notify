import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/network/error/exceptions.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/services/firebase%20services/notification%20services/notification_base_class.dart';
import 'package:notify/core/utils/services/firebase%20services/notification%20services/notification_base_class.dart';
import 'package:notify/features/auth/data/data_source/remote/remote_data_source.dart';
import 'package:notify/features/auth/presentation/controllers/login%20view%20model/login_view_modle.dart';
import 'package:notify/shared/domin/models/user_model.dart';
import 'package:notify/features/auth/domin/usecases/login.dart';
import 'package:notify/features/auth/domin/usecases/signup.dart';
import 'package:notify/features/auth/presentation/controllers/signup%20view%20model/signup_view_model.dart';
import 'package:notify/core/utils/services/firebase%20services/firebase_services.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();
  @override
  Future<UserModel> login(LoginParams params) async {
    try {
      var response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      if (response.user == null) {
        throw FirebaseAuthFailure(SignupViewModle.userNotFound);
      }

      ({String fullName, List<dynamic> joinedChannels}) user =
          await FirebaseServices.getUserData(response.user!.uid);
      await FirebaseServices.updateNotificationToken(response.user!.uid);
      // subsvribe to all the channels for the user
      for (var channelId in user.joinedChannels) {
        await sl<NotificationService>().subscribeToTopic(channelId as String);
      }
      return UserModel(
        email: params.email,
        id: response.user!.uid,
        fullName: user.fullName,
        joinedChannelsId: user.joinedChannels,
        // username: user.username,
      );
    } on FirebaseAuthException catch (e) {
      // print(e.code);
      // user-not-found
      // wrong-password
      switch (e.code) {
        case "weak-password":
          throw FirebaseAuthFailure(LoginViewModle.weakPassword);
        case "invalid-credential":
          throw FirebaseAuthFailure(LoginViewModle.wrongCredential);
        default:
          throw FirebaseAuthFailure(LoginViewModle.defaultError);
      }
    } on CacheException catch (e) {
      throw CacheFailure(e.message);
    }
  }

  @override
  Future<UserModel> signup(SignUpParams params) async {
    try {
      // await FirebaseServices.searchUsername(params.userName);
      var response = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      if (response.user == null) {
        throw FirebaseAuthFailure(SignupViewModle.userNotCreated);
      }
      await FirebaseServices.saveUserData(
          // params.userName,
          imageUrl: params.imageUrl,
          fullName: params.fullName,
          email: params.email,
          id: response.user!.uid);

      await FirebaseServices.updateNotificationToken(response.user!.uid);
      return UserModel(
        email: params.email,
        id: response.user!.uid,
        fullName: params.fullName,
        joinedChannelsId: [],
        // username: params.userName,
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
      await FirebaseServices.saveUserData(
          // params.userName,
          imageUrl: user.photoURL,
          fullName: user.displayName!,
          email: user.email!,
          id: user.uid);
      await FirebaseServices.updateNotificationToken(user.uid);

      return UserModel(
        email: user.email!,
        id: user.uid,
        fullName: user.displayName!,
        joinedChannelsId: [],
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
      throw FirebaseAuthFailure(e.toString());
    }
  }
}
