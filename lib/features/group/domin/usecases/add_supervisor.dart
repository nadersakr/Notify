import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/group/domin/repositories/group_repository.dart';
import 'package:notify/shared/domin/entities/group_model.dart';

class AddSupervisorGroup extends UseCase<void, AddSupervisorParams> {
  final GroupRepository repository;

  AddSupervisorGroup(this.repository);

  @override
  Future<Either<Failure, void>> call(AddSupervisorParams params) async {
    final result = await repository.addSupervisor(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      void r;
      return Right(r);
    });
  }
}

class AddSupervisorParams {
  final Group group;
  final int supervisorId;
  const AddSupervisorParams({
    required this.group,
    required this.supervisorId,
  });
}
