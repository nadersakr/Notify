import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/channel%20manipulation/domin/repositories/channel_repository.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';

class JoinChannel extends UseCase<void, JoinChannelParams> {
  final ChannelRepository repository;

  JoinChannel(this.repository);

  @override
  Future<Either<Failure, void>> call(JoinChannelParams params) async {
    final result = await repository.joinChannel(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      void r;
      return Right(r);
    });
  }
}

class JoinChannelParams {
  final Channel channel;
  final int joinerId;
  const JoinChannelParams({
    required this.channel,
    required this.joinerId,
  });
}
