import 'dart:convert';
import 'package:notify/core/network/error/exceptions.dart';
import 'package:notify/core/utils/shared%20preferances/shared_preferences.dart';
import 'package:notify/features/auth/data/data_source/local/local_data_sourece.dart';
import 'package:notify/shared/domin/entities/user_model.dart';

class AuthLocalDataSourceImp implements AuthLocalDataSource {
  final SaveDataLocal saveDataLocal;

  AuthLocalDataSourceImp({required this.saveDataLocal});

  @override
  Future<void> cacheUser(UserModel user) async {
    await saveDataLocal.saveData("user", jsonEncode(user.toJson()));
  }

  @override
  UserModel getUser() {
    final user = saveDataLocal.getData("user");
    if (user != null) {
      return UserModel.fromJson(jsonDecode(user));
    } else {
      throw CacheException("No user found");
    }
  }
}
