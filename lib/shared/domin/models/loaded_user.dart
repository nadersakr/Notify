// apply singleTon pattern for this class to be used in all the app
import 'package:notify/shared/domin/models/channel_model.dart';
import 'package:notify/shared/domin/models/notification_model.dart';
import 'package:notify/shared/domin/models/user_model.dart';

class LoadedUserData {
  UserModel? loadedUser;
  // give them a fake data for loading using Skeletonizer package
  static List<Channel> userownedChannels = [];
  static List<Channel> biggestChannels = [];
  static List<Channel> joindChannels = [];
  static List<NotificationModel> notifications = [];
  static String? notificationToken;

  // Private constructor
  LoadedUserData._privateConstructor();

  // Static field to hold the single instance
  static final LoadedUserData _instance = LoadedUserData._privateConstructor();

  // Factory constructor that returns the same instance every time
  factory LoadedUserData() {
    return _instance;
  }
}
