// apply singleTon pattern for this class to be used in all the app
import 'package:notify/shared/domin/entities/user_model.dart';

class LoadedUserData {
  late final UserModel? loadedUser;

  // Private constructor
  LoadedUserData._privateConstructor();

  // Static field to hold the single instance
  static final LoadedUserData _instance = LoadedUserData._privateConstructor();

  // Factory constructor that returns the same instance every time
  factory LoadedUserData() {
    return _instance;
  }
}
