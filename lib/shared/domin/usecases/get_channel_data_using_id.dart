import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/domin/repositories/get_channel_data_repository.dart';

class GetChannelData extends UseCase<Channel, GetChannelInfoParams> {
  final GetChannelDataRepository repository;

  GetChannelData(this.repository);

  @override
  Future<Either<Failure, Channel>> call(GetChannelInfoParams params) async {
    final result = await repository.getChannelData(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
class GetChannelInfoParams {
  final String channelId;

  GetChannelInfoParams({required this.channelId});
}