import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/domin/usecases/get_channel_data_using_id.dart';

abstract class GetChannelDataRepository {
  Future<Either<Failure,Channel>> getChannelData(GetChannelInfoParams params);
}