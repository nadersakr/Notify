import 'package:get_it/get_it.dart';
import 'package:notify/core/network/network_info.dart';
import 'package:notify/core/utils/shared%20preferances/shared_preferences.dart';
import 'package:notify/features/auth/data/data_source/local/local_data_source_impl.dart';
import 'package:notify/features/auth/data/data_source/local/local_data_sourece.dart';
import 'package:notify/features/auth/data/data_source/remote/remote_data_source.dart';
import 'package:notify/features/auth/data/data_source/remote/remote_data_source_impl.dart';
import 'package:notify/features/auth/data/repository/auth_repo_impl.dart';
import 'package:notify/features/auth/domin/repository/auth_repository.dart';
import 'package:notify/features/auth/domin/usecases/log_out.dart';
import 'package:notify/features/auth/domin/usecases/login.dart';
import 'package:notify/features/auth/domin/usecases/signin_with_google.dart';
import 'package:notify/features/auth/domin/usecases/signup.dart';
import 'package:notify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:notify/features/channel%20manipulation/data/data%20source/remote/remote_data_source.dart';
import 'package:notify/features/channel%20manipulation/data/data%20source/remote/remote_data_source_impl.dart';
import 'package:notify/features/channel%20manipulation/data/repositories/channel_repository_impl.dart';
import 'package:notify/features/channel%20manipulation/domin/repositories/channel_repository.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/create_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/delete_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/join_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/leave_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/send_notification.dart';
import 'package:notify/features/channel%20manipulation/presentation/bloc/channel_bloc.dart';
import 'package:notify/features/display%20channel/data/data%20source/display_channel_remote_data_source.dart';
import 'package:notify/features/display%20channel/data/data%20source/display_channel_remote_data_source_impl.dart';
import 'package:notify/features/display%20channel/data/repositories/display_channel_repositoriy_impl.dart';
import 'package:notify/features/display%20channel/domin/repositories/display_channel_repository.dart';
import 'package:notify/features/display%20channel/domin/usecases/load_channel_data.dart';
import 'package:notify/features/display%20channel/presentation/bloc/display_channel_bloc.dart';
import 'package:notify/features/home%20screen/data%20layer/data%20source/remote/remote_data_source.dart';
import 'package:notify/features/home%20screen/data%20layer/data%20source/remote/remote_data_source_impl.dart';
import 'package:notify/features/home%20screen/data%20layer/repositories/home_repository_impl.dart';
import 'package:notify/features/home%20screen/domin/repositories/home_repository.dart';
import 'package:notify/features/home%20screen/domin/usecase/get_biggest_channel.dart';
import 'package:notify/features/home%20screen/domin/usecase/get_user_data.dart';
import 'package:notify/features/home%20screen/presentation/bloc/home_bloc.dart';
import 'package:notify/features/profile/data/data%20source/remote/remote_data_source.dart';
import 'package:notify/features/search/presentation/bloc/search_bloc.dart';
import 'package:notify/shared/data%20layer/data%20source/remote%20data%20source/get%20channel%20data/remote_data_source.dart';
import 'package:notify/shared/data%20layer/data%20source/remote%20data%20source/get%20channel%20data/remote_data_source.impl.dart';
import 'package:notify/shared/data%20layer/data%20source/remote%20data%20source/get%20user%20profile%20data/remote/remote_data_source_impl.dart';
import 'package:notify/shared/data%20layer/data%20source/remote%20data%20source/image_util.dart/image_util_remote_data_source.dart';
import 'package:notify/shared/data%20layer/data%20source/remote%20data%20source/image_util.dart/image_util_remote_data_source_impl.dart';
import 'package:notify/shared/data%20layer/repositories/get_channel_data_repo_impl.dart';
import 'package:notify/shared/data%20layer/repositories/image_util_repository_impl.dart';
import 'package:notify/shared/data%20layer/repositories/profile_repository_impl.dart';
import 'package:notify/shared/domin/repositories/Image_util_repository.dart';
import 'package:notify/shared/domin/repositories/get_channel_data_repository.dart';
import 'package:notify/shared/domin/repositories/profile_repository.dart';
import 'package:notify/shared/domin/usecases/compress_image_usecase.dart';
import 'package:notify/shared/domin/usecases/get_channel_data_using_id.dart';
import 'package:notify/shared/domin/usecases/get_user_info.dart';
import 'package:notify/shared/domin/usecases/upload_image_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  await initSharedPrefsInjections();
  await saveLocalDataInjection();
  await networkInjections();
  await authLocalDataSourceImplInjections();
  await authRemoteDataSourceInjections();
  await authRepositoryAppInjections();
  await authUseCasesInjections();
  await authBlocinjections();
  await searchBlocInjections();
  await imageUtilInjections();
  await channelFeatureInjection();
  await displaychannelFeatureInjection();
  await homeScreenBlocInjections();
  await getChannelDataInjection();
  await getUserDataInjection();
}

authBlocinjections() async {
  // I need to make one inssatnce of the bloc

  sl.registerFactory<AuthBloc>(() => AuthBloc(
        login: sl<Login>(),
        signup: sl<Signup>(),
        signinWithGooogle: sl<SigninWithGoogle>(),
        logOut: sl<LogOut>(),
      ));
}

searchBlocInjections() async {
  // I need to make one inssatnce of the bloc

  sl.registerFactory<SearchBloc>(() => SearchBloc());
}

authUseCasesInjections() async {
  sl.registerFactory<Signup>(() => Signup(sl<AuthRepository>()));
  sl.registerFactory<Login>(() => Login(sl<AuthRepository>()));
  sl.registerFactory<SigninWithGoogle>(
      () => SigninWithGoogle(sl<AuthRepository>()));
  sl.registerFactory<LogOut>(() => LogOut(sl<AuthRepository>()));
}

imageUtilInjections() async {
  sl.registerFactory<ImageUtilRemoteDataSource>(
      () => ImageUtilRemoteDataSourceImpl());

  sl.registerSingletonAsync<ImageUtilRepository>(() async {
    return ImageUtilRepositoryImpl(
        networkInfo: sl<NetworkInfo>(),
        remoteDataSource: sl<ImageUtilRemoteDataSource>());
  });
  sl.registerFactory<UploadImage>(() => UploadImage(sl<ImageUtilRepository>()));
  sl.registerFactory<CompressImage>(
      () => CompressImage(sl<ImageUtilRepository>()));
}

channelFeatureInjection() async {
  sl.registerFactory<ChannelRemoteDataSource>(
      () => ChannelRemoteDataSourceImpl());

  sl.registerSingletonAsync<ChannelRepository>(() async {
    return ChannelRepositoryImpl(
        networkInfo: sl<NetworkInfo>(),
        remoteDataSource: sl<ChannelRemoteDataSource>());
  });
  sl.registerFactory<CreateChannel>(
      () => CreateChannel(sl<ChannelRepository>()));
  sl.registerFactory<LeaveChannel>(() => LeaveChannel(sl<ChannelRepository>()));
  sl.registerFactory<SendNotification>(
      () => SendNotification(sl<ChannelRepository>()));
  sl.registerFactory<DeleteChannel>(
      () => DeleteChannel(sl<ChannelRepository>()));
  sl.registerFactory<JoinChannel>(() => JoinChannel(sl<ChannelRepository>()));
  sl.registerFactory<ChannelBloc>(() => ChannelBloc(
      joinChannel: sl<JoinChannel>(),
      createChannel: sl<CreateChannel>(),
      sendNotifaction: sl<SendNotification>(),
      leaveChannel: sl<LeaveChannel>(),
      deleteChannel: sl<DeleteChannel>()));
}

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

networkInjections() async {
  sl.registerSingletonAsync<NetworkInfo>(() async {
    return NetworkInfoImpl();
  });
  await sl.isReady<NetworkInfo>();
}

authRemoteDataSourceInjections() async {
  sl.registerSingletonAsync<AuthRemoteDataSource>(() async {
    return AuthRemoteDataSourceImpl();
  });
  await sl.isReady<AuthRemoteDataSource>();
}

saveLocalDataInjection() {
  sl.registerFactory<SaveDataLocal>(() =>
      SharedPreferencesServices(sharedPreferences: sl<SharedPreferences>()));
}

authLocalDataSourceImplInjections() async {
  sl.registerSingletonAsync<AuthLocalDataSource>(() async {
    return AuthLocalDataSourceImp(
      saveDataLocal: sl<SaveDataLocal>(),
    );
  });
  await sl.isReady<AuthLocalDataSource>();
}

authRepositoryAppInjections() async {
  sl.registerSingletonAsync<AuthRepository>(() async {
    return AuthRepositoryImpl(
      localDataSource: sl<AuthLocalDataSource>(),
      remoteDataSource: sl<AuthRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    );
  });
  await sl.isReady<AuthRepository>();
}

initSharedPrefsInjections() async {
  sl.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
  await sl.isReady<SharedPreferences>();
}

homeScreenBlocInjections() async {
  sl.registerFactory<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl());

  sl.registerSingletonAsync<HomeRepository>(() async {
    return HomeRepositoryImpl(
        networkInfo: sl<NetworkInfo>(),
        remoteDataSource: sl<HomeRemoteDataSource>());
  });
  sl.registerFactory<GetBiggestChannels>(
      () => GetBiggestChannels(sl<HomeRepository>()));
  sl.registerFactory<GetUserData>(() => GetUserData(sl<HomeRepository>()));
  sl.registerFactory<HomeBloc>(() => HomeBloc(
      getBiggestChannels: sl<GetBiggestChannels>(),
      getUserData: sl<GetUserData>()));
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
