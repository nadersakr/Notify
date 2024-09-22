import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/features/display%20channel/domin/usecases/load_channel_data.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';

abstract class DisplayChannelRepository {
    Future<Either<Failure,Channel>> getChannelData(LoadChannelDataParams params);
}