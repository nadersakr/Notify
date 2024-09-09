import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/group/domin/repositories/group_repository.dart';
import 'package:notify/shared/domin/entities/group_model.dart';

class LeaveGroup extends UseCase<void, LeaveGroupParams> {
  final GroupRepository repository;

  LeaveGroup(this.repository);

  @override
  Future<Either<Failure, void>> call(LeaveGroupParams params) async {
    final result = await repository.leaveGroup(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      void r;
      return Right(r);
    });
  }
}

class LeaveGroupParams {
  final Group group;
  final int leaverId;
  const LeaveGroupParams({
    required this.group,
    required this.leaverId,
  });
}
