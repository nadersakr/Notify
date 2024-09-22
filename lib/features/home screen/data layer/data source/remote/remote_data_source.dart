import 'package:notify/shared/domin/entities/channel_model.dart';

abstract class HomeRemoteDataSource{
  Future<List<Channel>> getBiggestChannels();
}