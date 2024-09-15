import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/group/domin/repositories/group_repository.dart';
import 'package:notify/shared/domin/entities/group_model.dart';

class JoinGroup extends UseCase<void, JoinGroupParams> {
  final GroupRepository repository;

  JoinGroup(this.repository);

  @override
  Future<Either<Failure, void>> call(JoinGroupParams params) async {
    final result = await repository.joinGroup(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      void r;
      return Right(r);
    });
  }
}

class JoinGroupParams {
  final Channel channel;
  final int joinerId;
  const JoinGroupParams({
    required this.channel,
    required this.joinerId,
  });
}
