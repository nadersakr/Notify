import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notify/core/network/error/failures.dart';

class FirebaseServices {
  static Future<void> saveUserData(
      String username, String firstName, String lastName, String id) async {
    try {
      // Save User data using UID
      await FirebaseFirestore.instance.collection('users').doc(id).set({
        'firstName': firstName,
        'lastName': lastName,
      });

      try {
        // Save User data using username
        await FirebaseFirestore.instance
            .collection('usernames')
            .doc(username)
            .set({
          'id': id,
        });
      } catch (e) {
        throw const ServerFailure("Usernamer didn't save", 402);
      }
    } catch (e) {
      throw const ServerFailure("Server Failure", 402);
    }
  }
}