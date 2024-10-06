import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/channel%20manipulation/domin/repositories/channel_repository.dart';
import 'package:notify/shared/domin/models/channel_model.dart';

class CreateChannel extends UseCase<void, CreateChannelParams> {
  final ChannelRepository repository;

  CreateChannel(this.repository);

  @override
  Future<Either<Failure, void>> call(CreateChannelParams params) async {
    final result = await repository.createChannel(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      void r;
      return Right(r);
    });
  }
}

class CreateChannelParams {
  final Channel channel;

  const CreateChannelParams({
    required this.channel,
   
  });
}
