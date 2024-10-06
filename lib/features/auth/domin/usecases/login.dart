import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/shared/domin/models/user_model.dart';
import 'package:notify/features/auth/domin/repository/auth_repository.dart';

class Login extends UseCase<UserModel, LoginParams> {
  final AuthRepository repository;

  Login(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(LoginParams params) async {
    final result = await repository.login(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}

class LoginParams {
 final  String email;
 final String password;
  const LoginParams({required this.email,required this.password});
}
