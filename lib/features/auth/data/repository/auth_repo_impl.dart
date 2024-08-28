import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/features/auth/domin/entities/user_model.dart';
import 'package:notify/features/auth/domin/repository/auth_repository.dart';
import 'package:notify/features/auth/domin/usecases/login.dart';

class AuthRepositoryImpl implements AuthRepository {
  // final AuthRemoteDataSource remoteDataSource;
  // final AuthLocalDataSource localDataSource;
  // final NetworkInfo networkInfo;

  AuthRepositoryImpl(
    // required this.remoteDataSource,
    // required this.localDataSource,
    // required this.networkInfo,
  );

  @override
  Future<Either<Failure, UserModel>> login(LoginParams login) {
    // TODO: implement login
    throw UnimplementedError();
  }

  // @override
  // Future<Either<Failure, User>> login(LoginParams loginParams) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final user = await remoteDataSource.login(loginParams);
  //       localDataSource.cacheUser(user);
  //       return Right(user);
  //     } on ServerException {
  //       return Left(ServerFailure());
  //     }
  //   } else {
  //     try {
  //       final user = await localDataSource.getLastUser();
  //       return Right(user);
  //     } on CacheException {
  //       return Left(CacheFailure());
  //     }
  //   }
  // }
}



