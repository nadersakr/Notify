import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/network/network_info.dart';
import 'package:notify/shared/data%20layer/data%20source/remote%20data%20source/get%20channel%20data/remote_data_source.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/domin/repositories/get_channel_data_repository.dart';
import 'package:notify/shared/domin/usecases/get_channel_data_using_id.dart';

class GetChannelDataRepoImpl implements GetChannelDataRepository {
  final GetChannelDataRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  GetChannelDataRepoImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Channel>> getChannelData(
      GetChannelInfoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        Channel response = await remoteDataSource.getChannelData(params);
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
