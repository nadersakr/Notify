import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/channel%20manipulation/domin/repositories/channel_repository.dart';
import 'package:notify/shared/domin/models/channel_model.dart';
import 'package:notify/shared/domin/models/notification_model.dart';

class SendNotification extends UseCase<void, SendNotificationParams> {
  final ChannelRepository repository;
  SendNotification(this.repository);

  @override
  Future<Either<Failure, void>> call(SendNotificationParams params) async {
    final result = await repository.sendNotification(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      void r;
      return Right(r);
    });
  }
}

class SendNotificationParams {
  final NotificationModel notification;
  final Channel channel;

  const SendNotificationParams({
    required this.notification,
    required this.channel,
   
  });
}
