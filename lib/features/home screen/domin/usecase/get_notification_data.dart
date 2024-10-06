import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/home%20screen/domin/repositories/home_repository.dart';
import 'package:notify/shared/domin/models/notification_model.dart';
class GetNotificationData extends UseCase<NotificationModel, GetNotificationInfoParams> {
  final HomeRepository repository;

  GetNotificationData(this.repository);

  @override
  Future<Either<Failure, NotificationModel>> call(GetNotificationInfoParams params) async {
    final result = await repository.getNotificationData(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
class GetNotificationInfoParams {
  final String notificationId;

  GetNotificationInfoParams({required this.notificationId});
}