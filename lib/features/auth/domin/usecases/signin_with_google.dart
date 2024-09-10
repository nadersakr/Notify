import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/auth/domin/repository/auth_repository.dart';
import 'package:notify/shared/domin/entities/user_model.dart';

class SigninWithGoogle extends UseCase<UserModel, NoParams> {
  final AuthRepository repository;

  SigninWithGoogle(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    final result = await repository.signinWithGoogle();
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}


