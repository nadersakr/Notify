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
import 'package:notify/features/channel%20manipulation/presentation/bloc/channel_bloc.dart';
import 'package:notify/features/search/presentation/bloc/search_bloc.dart';
import 'package:notify/shared/data%20layer/data%20source/remote%20data%20source/image_util.dart/image_util_remote_data_source.dart';
import 'package:notify/shared/data%20layer/data%20source/remote%20data%20source/image_util.dart/image_util_remote_data_source_impl.dart';
import 'package:notify/shared/data%20layer/repositories/image_util_repository_impl.dart';
import 'package:notify/shared/domin/repositories/Image_util_repository.dart';
import 'package:notify/shared/domin/usecases/compress_image_usecase.dart';
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
  // await initHTTPInjections();
  await authUseCasesInjections();
  // await initArticlesInjections();
  await authBlocinjections();
  await searchBlocInjections();
  await imageUtilInjections();
  await channelFeatureInjection();
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
  sl.registerFactory<ChannelBloc>(
      () => ChannelBloc(createChannel: sl<CreateChannel>()));
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

// Future<void> initHTTPInjections() async {
//   // initRootLogger();
//   // DioNetwork.initDio();
// }


