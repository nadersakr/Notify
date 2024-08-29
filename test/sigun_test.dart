// import 'package:flutter_test/flutter_test.dart';
// import 'package:notify/core/network/network_info.dart';
// import 'package:notify/core/utils/shared%20preferances/shared_preferences.dart';
// import 'package:notify/features/auth/data/data_source/local/local_data_source_impl.dart';
// import 'package:notify/features/auth/data/data_source/local/local_data_sourece.dart';
// import 'package:notify/features/auth/data/data_source/remote_data_source.dart';
// import 'package:notify/features/auth/data/data_source/remote_data_source_impl.dart';
// import 'package:notify/features/auth/data/repository/auth_repo_impl.dart';
// import 'package:notify/features/auth/domin/repository/auth_repository.dart';
// import 'package:notify/features/auth/domin/usecases/signup.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() async {
//   TestWidgetsFlutterBinding.ensureInitialized();

//   setUp(() async {
//     // Any setup code if needed
//   });

//   test('should return UserModel when signup is successful', () async {
//     // Arrange
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     SharedPreferencesServices sharedPreferencesServices =
//         SharedPreferencesServices(sharedPreferences: sharedPreferences);
//     AuthLocalDataSource authLocalDataSourceImpl = AuthLocalDataSourceImp(
//       saveDataLocal: sharedPreferencesServices,
//     );
//     NetworkInfo networkInfo = NetworkInfoImpl();
//     AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSourceImpl();

//     AuthRepository authRepository = AuthRepositoryImpl(
//         localDataSource: authLocalDataSourceImpl,
//         remoteDataSource: authRemoteDataSource,
//         networkInfo: networkInfo);
//     const params = SignUpParams(
//       firstName: 'John',
//       lastName: 'Doe',
//       userName: 'johndoe',
//       email: 'johndoe@example.com',
//       password: 'password',
//     );

//     // Act
//     final result = await Signup(authRepository).call(params);
//     print(result);
//     result.fold((l) {
//       print(l);
//     }, (r) {
//       print(r);
//     });
//   });
// }