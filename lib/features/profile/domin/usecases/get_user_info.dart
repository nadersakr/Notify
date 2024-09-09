import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/profile/domin/repositories/profile_repository.dart';

class GetUserInfo extends UseCase<void, GetUserInfoParams> {
  final ProfileRepository repository;

  GetUserInfo(this.repository);

  @override
  Future<Either<Failure, void>> call(GetUserInfoParams params) async {
    final result = await repository.getUserInfo(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      void r;
      return Right(r);
    });
  }
}

class GetUserInfoParams {
  final String userId;
  const GetUserInfoParams({
    required this.userId,
  });
}
