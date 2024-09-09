import 'package:notify/shared/domin/entities/user_model.dart';

abstract class ProfileLocalDataSource {
  // fetch locally user data
  Future<UserModel> getUserDataLocally();
}
