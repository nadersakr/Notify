import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/network/network_info.dart';
import 'package:notify/features/profile/data/data%20source/local/local_data_source.dart';
import 'package:notify/features/profile/data/data%20source/remote/remote_data_source.dart';
import 'package:notify/features/profile/domin/repositories/profile_repository.dart';
import 'package:notify/features/profile/domin/usecases/get_user_info.dart';
import 'package:notify/shared/domin/entities/user_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const ProfileRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, UserModel>> getUserInfo(GetUserInfoParams params) async {
    if (await networkInfo.isConnected) {
      try {
        // if user id saved in local data fetch user data locally 
        // localDataSource
        // else fetch remotelly
      UserModel user =  await remoteDataSource.getUserInfo(params);
        return Right(user);
      } catch (e) {
        return Left(UnknowFailure("Error Occured:$e"));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
