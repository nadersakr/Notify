import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/network/network_info.dart';
import 'package:notify/features/display%20channel/data/data%20source/display_channel_remote_data_source.dart';
import 'package:notify/features/display%20channel/domin/repositories/display_channel_repository.dart';
import 'package:notify/features/display%20channel/domin/usecases/load_channel_data.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';

class DisplayChannelRepositoriyImpl implements DisplayChannelRepository {
  final DisplayChannelRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  DisplayChannelRepositoriyImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Channel>> getChannelData(
      LoadChannelDataParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final channel = await remoteDataSource.getChannelData(params);
        return Right(channel);
      } on CacheFailure catch (e) {
        return Left(CacheFailure(e.errorMessage));
      } on FirebaseException {
        return const Left(FirebaseErrorFailure("Firebase Error Occured"));
      } catch (e) {
        return const Left(UnknowFailure("Unknow Error Occured"));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
