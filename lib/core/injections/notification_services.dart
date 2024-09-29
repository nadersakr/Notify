import 'package:notify/core/app_injection.dart';
import 'package:notify/core/utils/services/firebase%20services/notification%20services/firebase_messaging.dart';
import 'package:notify/core/utils/services/firebase%20services/notification%20services/notification_base_class.dart';

notificationServicesInjection() async {
  sl.registerFactory<NotificationService>(
      () => FirebaseNotificationService());
}