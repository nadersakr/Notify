import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/channel%20manipulation/domin/repositories/channel_repository.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';

class LeaveChannel extends UseCase<void, LeaveChannelParams> {
  final ChannelRepository repository;

  LeaveChannel(this.repository);

  @override
  Future<Either<Failure, void>> call(LeaveChannelParams params) async {
    final result = await repository.leaveChannel(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      void r;
      return Right(r);
    });
  }
}

class LeaveChannelParams {
  final Channel channel;
  final int leaverId;
  const LeaveChannelParams({
    required this.channel,
    required this.leaverId,
  });
}
