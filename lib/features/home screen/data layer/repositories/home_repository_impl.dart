import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/network/network_info.dart';
import 'package:notify/features/home%20screen/data%20layer/data%20source/remote/remote_data_source.dart';
import 'package:notify/features/home%20screen/domin/repositories/home_repository.dart';
import 'package:notify/features/home%20screen/domin/usecase/get_notification_data.dart';
import 'package:notify/shared/domin/models/notification_model.dart';
import 'package:notify/shared/domin/models/channel_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  // final HomeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    // required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Channel>>> getBiggestChannels() async {
    if (await networkInfo.isConnected) {
      try {
        List<Channel> response = await remoteDataSource.getBiggestChannels();
        return Right(response);
      } on FirebaseErrorFailure catch (e) {
        return Left(FirebaseErrorFailure(e.toString()));
      } on UnknowFailure catch (e) {
        return Left(UnknowFailure("Unknow Failure $e"));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }



  @override
  Future<Either<Failure, NotificationModel>> getNotificationData(GetNotificationInfoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        NotificationModel response = await remoteDataSource.getNotificationData(params);
        return Right(response);
      } on FirebaseErrorFailure catch (e) {
        return Left(FirebaseErrorFailure(e.toString()));
      } on UnknowFailure catch (e) {
        return Left(UnknowFailure("Unknow Failure $e"));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
