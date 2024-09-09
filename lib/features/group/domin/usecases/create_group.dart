import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/group/domin/repositories/group_repository.dart';
import 'package:notify/shared/domin/entities/group_model.dart';

class CreateGroup extends UseCase<void, CreateGroupParams> {
  final GroupRepository repository;

  CreateGroup(this.repository);

  @override
  Future<Either<Failure, void>> call(CreateGroupParams params) async {
    final result = await repository.createGroup(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      void r;
      return Right(r);
    });
  }
}

class CreateGroupParams {
  final Group group;
  const CreateGroupParams({
    required this.group,
  });
}
