import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notify/core/network/error/exceptions.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/features/auth/presentation/controllers/login%20view%20model/login_view_modle.dart';
import 'package:notify/features/auth/presentation/controllers/signup%20view%20model/signup_view_model.dart';
import 'package:notify/shared/domin/models/loaded_user.dart';

class FirebaseServices {
  static Future<void> saveUserData(
      {
      // String username,
      String? imageUrl,
      required String fullName,
      required String email,
      required String id,
    }) async {
    try {
      // Save User data using UID
      await FirebaseFirestore.instance.collection('users').doc(id).set({
        'fullName': fullName,
        'email': email,
        'imageUrl': imageUrl,
        "notificationToken": LoadedUserData.notificationToken
        // 'username': username,
      });
    } catch (e) {
      throw CacheException(SignupViewModle.userDatadidnotSaved);
    }

    // try {
    //   // Save User data using username
    //   await FirebaseFirestore.instance
    //       .collection('usernames')
    //       .doc(username)
    //       .set({
    //     'id': id,
    //   });
    // } catch (e) {
    //   throw CacheException(SignupViewModle.usernameDidnotSaved);
    // }
  }

  // static Future<void> searchUsername(String username) async {
  //   try {
  //     final response = await FirebaseFirestore.instance
  //         .collection('usernames')
  //         .doc(username)
  //         .get();
  //     if (response.exists) {
  //       throw FirebaseAuthFailure(SignupViewModle.usernameAlreadyIn);
  //     }
  //   } catch (e) {
  //     throw FirebaseAuthFailure(SignupViewModle.usernameAlreadyIn);
  //   }
  // }

  static Future<({String fullName, List<dynamic> joinedChannels})> getUserData(
      String uid) async {
    try {
      final response =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      // print(response.data()!['firstName']);

      return (
        fullName: "${response.data()!['fullName']}",
        joinedChannels: (response.data()!['joinedChannels']??[]) as List<dynamic>,
      );
    } catch (e) {

      throw FirebaseAuthFailure(LoginViewModle.errorInLoadingUserData);
    }
  }

  static Future<void> updateNotificationToken(String userUid) async {
    try {
      // Save User data using UID
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userUid)
          .update({"notificationToken": LoadedUserData.notificationToken});
    } catch (e) {
      throw const FirebaseErrorFailure("Error in Updating Notification Token");
    }
  }
}
