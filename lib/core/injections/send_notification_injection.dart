import 'package:notify/core/app_injection.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/send_notification.dart';
import 'package:notify/features/notification/persentaion/bloc/send_notification_bloc.dart';

sendNotificationInjection() async {
  sl.registerFactory<SendNotificationBloc>(
      () => SendNotificationBloc(sendNotification: sl<SendNotification>()));
}
