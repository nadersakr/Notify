import 'package:notify/features/display%20channel/domin/usecases/load_channel_data.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';

abstract class DisplayChannelRemoteDataSource {
  Future<Channel> getChannelData(LoadChannelDataParams params);
}

