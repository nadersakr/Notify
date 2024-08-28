// import 'package:notify/features/auth/data/data_source/remote_data_source.dart';
// import 'package:notify/features/auth/domin/entities/user_model.dart';
// import 'package:notify/features/auth/domin/usecases/login.dart';

// class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
//   final FirebaseAuth firebaseAuth;
//   AuthRemoteDataSourceImpl({required this.firebaseAuth});
//   @override
//   Future<UserModel> login(LoginParams params) {
    
//   }


//   // @override
//   // Future<UserCredential> signInWithEmailAndPassword(
//   //     {required String email, required String password}) async {
//   //   try {
//   //     final userCredential = await firebaseAuth.signInWithEmailAndPassword(
//   //       email: email,
//   //       password: password,
//   //     );
//   //     return userCredential;
//   //   } on FirebaseAuthException catch (e) {
//   //     throw AuthException(code: e.code);
//   //   }
//   // }

//   // @override
//   // Future<UserCredential> signUpWithEmailAndPassword(
//   //     {required String email, required String password}) async {
//   //   try {
//   //     final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
//   //       email: email,
//   //       password: password,
//   //     );
//   //     return userCredential;
//   //   } on FirebaseAuthException catch (e) {
//   //     throw AuthException(code: e.code);
//   //   }
//   // }

//   // @override
//   // Future<void> signOut() async {
//   //   await firebaseAuth.signOut();
//   // }


// }

// class FirebaseAuth {
//   // Implementation of FirebaseAuth class goes here
  
// @override
// Future<UserModel> login(LoginParams params) async {
//   try {
//     // Perform the login operation using firebaseAuth
//     // ...
//     // Return the user model
//     // ...
//   } catch (e) {
//     // Handle any errors that occur during the login operation
//     // ...
//     // Rethrow the error or return an appropriate error response
//     // ...
//   }
// }

// @override
// Future<UserModel> signInWithEmailAndPassword(
//     {required String email, required String password}) async {
//   try {
//     final userCredential = await firebaseAuth.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     return userCredential;
//   } on FirebaseAuthException catch (e) {
//     throw AuthException(code: e.code);
//   }
// }

// @override
// Future<UserCredential> signUpWithEmailAndPassword(
//     {required String email, required String password}) async {
//   try {
//     final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     return userCredential;
//   } on FirebaseAuthException catch (e) {
//     throw AuthException(code: e.code);
//   }
// }

// @override
// Future<void> signOut() async {
//   await firebaseAuth.signOut();
// }
// }