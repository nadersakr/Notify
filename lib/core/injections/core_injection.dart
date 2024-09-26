import 'package:notify/core/app_injection.dart';
import 'package:notify/core/network/network_info.dart';
import 'package:notify/core/utils/shared%20preferances/shared_preferences.dart';
import 'package:notify/features/profile/data/data%20source/remote/remote_data_source.dart';
import 'package:notify/shared/data%20layer/data%20source/remote%20data%20source/get%20channel%20data/remote_data_source.dart';
import 'package:notify/shared/data%20layer/data%20source/remote%20data%20source/get%20channel%20data/remote_data_source.impl.dart';
import 'package:notify/shared/data%20layer/data%20source/remote%20data%20source/get%20user%20profile%20data/remote/remote_data_source_impl.dart';
import 'package:notify/shared/data%20layer/repositories/get_channel_data_repo_impl.dart';
import 'package:notify/shared/data%20layer/repositories/profile_repository_impl.dart';
import 'package:notify/shared/domin/repositories/get_channel_data_repository.dart';
import 'package:notify/shared/domin/repositories/profile_repository.dart';
import 'package:notify/shared/domin/usecases/get_channel_data_using_id.dart';
import 'package:notify/shared/domin/usecases/get_user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

networkInjections() async {
  sl.registerSingletonAsync<NetworkInfo>(() async {
    return NetworkInfoImpl();
  });
  await sl.isReady<NetworkInfo>();
}

saveLocalDataInjection() {
  sl.registerFactory<SaveDataLocal>(() =>
      SharedPreferencesServices(sharedPreferences: sl<SharedPreferences>()));
}

initSharedPrefsInjections() async {
  sl.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
  await sl.isReady<SharedPreferences>();
}



getChannelDataInjection() async {
  sl.registerFactory<GetChannelDataRemoteDataSource>(
      () => GetChannelDataRemoteDataSourceImpl());

  sl.registerSingletonAsync<GetChannelDataRepository>(() async {
    return GetChannelDataRepoImpl(
        networkInfo: sl<NetworkInfo>(),
        remoteDataSource: sl<GetChannelDataRemoteDataSource>());
  });

  sl.registerFactory<GetChannelData>(
      () => GetChannelData(sl<GetChannelDataRepository>()));
}

getUserDataInjection() async {
  sl.registerFactory<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl());

  sl.registerSingletonAsync<ProfileRepository>(() async {
    return ProfileRepositoryImpl(
        networkInfo: sl<NetworkInfo>(),
        remoteDataSource: sl<ProfileRemoteDataSource>());
  });

  sl.registerFactory<GetUserInfo>(() => GetUserInfo(sl<ProfileRepository>()));
}
