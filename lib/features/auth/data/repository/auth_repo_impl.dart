import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/network/network_info.dart';
import 'package:notify/features/auth/data/data_source/local/local_data_sourece.dart';
import 'package:notify/features/auth/data/data_source/remote/remote_data_source.dart';
import 'package:notify/shared/domin/entities/user_model.dart';
import 'package:notify/features/auth/domin/repository/auth_repository.dart';
import 'package:notify/features/auth/domin/usecases/login.dart';
import 'package:notify/features/auth/domin/usecases/signup.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserModel>> login(LoginParams login) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signup(SignUpParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.signup(params);
        localDataSource.cacheUser(user);
        return Right(user);
      } on FirebaseAuthFailure catch (e) {
        return Left(FirebaseAuthFailure(e.errorMessage));
      } on CacheFailure catch (e) {
        return Left(CacheFailure(e.errorMessage));
      } catch (e) {
        return const Left(UnknowFailure("Error Occured"));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> signinWithGoogle() async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.signinWithGoogle();
        localDataSource.cacheUser(user);
        return Right(user);
      } on FirebaseAuthFailure catch (e) {
        return Left(FirebaseAuthFailure(e.errorMessage));
      } on CacheFailure catch (e) {
        return Left(CacheFailure(e.errorMessage));
      } catch (e) {
        return const Left(UnknowFailure("Error Occured"));
      }
    } else {
      return const Left(NetworkFailure());
    }
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
