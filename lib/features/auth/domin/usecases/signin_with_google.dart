import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/auth/domin/repository/auth_repository.dart';

class SigninWithGoogle extends UseCase<User, NoParams> {
  final AuthRepository repository;

  SigninWithGoogle(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    final result = await repository.signinWithGoogle();
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}


