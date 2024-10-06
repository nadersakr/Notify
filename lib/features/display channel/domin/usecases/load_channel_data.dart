import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/display%20channel/domin/repositories/display_channel_repository.dart';
import 'package:notify/shared/domin/models/channel_model.dart';

class LoadChannelData extends UseCase<Channel, LoadChannelDataParams> {
  final DisplayChannelRepository repository;

  LoadChannelData(this.repository);

  @override
  Future<Either<Failure, Channel>> call(LoadChannelDataParams params) async {
    final result = await repository.getChannelData(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}

class LoadChannelDataParams {
  final String channelId;

  LoadChannelDataParams({required this.channelId});
}
