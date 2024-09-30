import 'package:notify/core/app_injection.dart';
import 'package:notify/core/network/network_info.dart';
import 'package:notify/features/home%20screen/data%20layer/data%20source/remote/remote_data_source.dart';
import 'package:notify/features/home%20screen/data%20layer/data%20source/remote/remote_data_source_impl.dart';
import 'package:notify/features/home%20screen/data%20layer/repositories/home_repository_impl.dart';
import 'package:notify/features/home%20screen/domin/repositories/home_repository.dart';
import 'package:notify/features/home%20screen/domin/usecase/get_biggest_channel.dart';
import 'package:notify/features/home%20screen/domin/usecase/get_notification_data.dart';

homeScreenInjections() async {
  sl.registerFactory<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl());

  sl.registerSingletonAsync<HomeRepository>(() async {
    return HomeRepositoryImpl(
        networkInfo: sl<NetworkInfo>(),
        remoteDataSource: sl<HomeRemoteDataSource>());
  });
  sl.registerFactory<GetBiggestChannels>(
      () => GetBiggestChannels(sl<HomeRepository>()));
  sl.registerFactory<GetNotificationData>(() => GetNotificationData(sl<HomeRepository>()));
}
