import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/home%20screen/domin/repositories/home_repository.dart';
import 'package:notify/features/profile/domin/usecases/get_user_info.dart';
import 'package:notify/shared/domin/entities/user_model.dart';

class GetUserData extends UseCase<UserModel, GetUserInfoParams> {
  final HomeRepository repository;

  GetUserData(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(GetUserInfoParams params) async {
    final result = await repository.getUserData(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
