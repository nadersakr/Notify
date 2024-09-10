import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notify/core/network/error/exceptions.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/features/auth/presentation/controllers/login%20view%20model/login_view_modle.dart';
import 'package:notify/features/auth/presentation/controllers/signup%20view%20model/signup_view_model.dart';

class FirebaseServices {
  static Future<void> saveUserData(
      // String username,
       String fullName, String id) async {
    try {
      // Save User data using UID
      await FirebaseFirestore.instance.collection('users').doc(id).set({
        'fullName': fullName,
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

  static Future<({String fullName, String username})>
      getUserData(String uid) async {
    try {
      final response =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      // print(response.data()!['firstName']);


      return (fullName: "${response.data()!['fullName']}", username: "${response.data()!['username']}");
    } catch (e) {
      throw FirebaseAuthFailure(LoginViewModle.errorInLoadingUserData);
    }
  }
}

var r = (firstName: 'firstName', last: 'lastName', username: 'username');
