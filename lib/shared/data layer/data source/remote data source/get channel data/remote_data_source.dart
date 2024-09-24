import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/domin/usecases/get_channel_data_using_id.dart';

abstract class GetChannelDataRemoteDataSource {
  Future<Channel> getChannelData(GetChannelInfoParams params);
}