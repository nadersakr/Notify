import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/features/home%20screen/domin/usecase/get_notification_data.dart';
import 'package:notify/shared/domin/models/notification_model.dart';
import 'package:notify/shared/domin/models/channel_model.dart';

abstract class HomeRepository {
Future<Either<Failure,List<Channel>>> getBiggestChannels();
Future<Either<Failure,NotificationModel>> getNotificationData(GetNotificationInfoParams params);
}