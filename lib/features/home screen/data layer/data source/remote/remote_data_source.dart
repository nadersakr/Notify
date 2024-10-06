import 'package:notify/features/home%20screen/domin/usecase/get_notification_data.dart';
import 'package:notify/shared/domin/models/notification_model.dart';
import 'package:notify/shared/domin/models/channel_model.dart';

abstract class HomeRemoteDataSource{
  Future<List<Channel>> getBiggestChannels();
  Future<NotificationModel> getNotificationData(GetNotificationInfoParams params);
}