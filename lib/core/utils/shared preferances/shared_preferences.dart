import 'package:shared_preferences/shared_preferences.dart';

abstract class SaveDataLocal {
  Future<void> saveData(String key, String value);
  String? getData(String key);
  Future<void> removeData(String key);
}

class SharedPreferencesServices implements SaveDataLocal {
  final SharedPreferences sharedPreferences;

  SharedPreferencesServices({required this.sharedPreferences});

  @override
    String? getData(String key) {
    return sharedPreferences.getString(key) ?? '';
  }

  @override
  Future<Future<bool>> removeData(String key) async {
    return sharedPreferences.remove(key);
  }

  @override
  Future<bool> saveData(String key, String value) async {
    return await sharedPreferences.setString(key, value);
  }
}