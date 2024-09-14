import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/auth/domin/repository/auth_repository.dart';

class LogOut extends UseCase<void, NoParams> {
  final AuthRepository repository;

  LogOut(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    final result = await repository.logOut();
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}


