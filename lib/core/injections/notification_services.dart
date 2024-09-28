import 'package:notify/core/app_injection.dart';
import 'package:notify/shared/data%20layer/data%20source/remote%20data%20source/firebase%20services/notification%20services/firebase_messaging.dart';
import 'package:notify/shared/data%20layer/data%20source/remote%20data%20source/firebase%20services/notification%20services/notification_base_class.dart';

notificationServicesInjection() async {
  sl.registerFactory<NotificationService>(
      () => FirebaseNotificationService());
}