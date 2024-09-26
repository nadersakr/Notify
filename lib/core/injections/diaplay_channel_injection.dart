import 'package:notify/core/app_injection.dart';
import 'package:notify/core/network/network_info.dart';
import 'package:notify/features/display%20channel/data/data%20source/display_channel_remote_data_source.dart';
import 'package:notify/features/display%20channel/data/data%20source/display_channel_remote_data_source_impl.dart';
import 'package:notify/features/display%20channel/data/repositories/display_channel_repositoriy_impl.dart';
import 'package:notify/features/display%20channel/domin/repositories/display_channel_repository.dart';
import 'package:notify/features/display%20channel/domin/usecases/load_channel_data.dart';
import 'package:notify/features/display%20channel/presentation/bloc/display_channel_bloc.dart';


displaychannelFeatureInjection() async {
  sl.registerFactory<DisplayChannelRemoteDataSource>(
      () => DisplayChannelRemoteDataSourceImpl());

  sl.registerSingletonAsync<DisplayChannelRepository>(() async {
    return DisplayChannelRepositoriyImpl(
        networkInfo: sl<NetworkInfo>(),
        remoteDataSource: sl<DisplayChannelRemoteDataSource>());
  });
  sl.registerFactory<LoadChannelData>(
      () => LoadChannelData(sl<DisplayChannelRepository>()));
  sl.registerFactory<DisplayChannelBloc>(
      () => DisplayChannelBloc(loadChannelData: sl<LoadChannelData>()));
}
