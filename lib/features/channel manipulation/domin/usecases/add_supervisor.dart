import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/channel%20manipulation/domin/repositories/channel_repository.dart';

class AddSupervisorChannel extends UseCase<void, AddSupervisorParams> {
  final ChannelRepository repository;

  AddSupervisorChannel(this.repository);

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
  final String channelId;
  final String supervisorId;
  const AddSupervisorParams({
    required this.channelId,
    required this.supervisorId,
  });
}
