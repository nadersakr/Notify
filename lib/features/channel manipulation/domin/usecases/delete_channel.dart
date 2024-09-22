import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/channel%20manipulation/domin/repositories/channel_repository.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';

class DeleteChannel extends UseCase<void, DeleteChannelParams> {
  final ChannelRepository repository;

  DeleteChannel(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteChannelParams params) async {
    final result = await repository.deleteChannel(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      void r;
      return Right(r);
    });
  }
}

class DeleteChannelParams {
  final Channel channel;

  const DeleteChannelParams({
    required this.channel,
   
  });
}
