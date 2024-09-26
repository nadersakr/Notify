import 'package:notify/core/app_injection.dart';
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

authinjections() async {
// for the local data source
  sl.registerSingleton<AuthLocalDataSource>(
     AuthLocalDataSourceImp(
      saveDataLocal: sl<SaveDataLocal>(),
    )
  );
  // for the remote data source
  sl.registerSingleton<AuthRemoteDataSource>(
     AuthRemoteDataSourceImpl()
  );

// for the repository
  sl.registerSingletonAsync<AuthRepository>(() async {
    return AuthRepositoryImpl(
      localDataSource: sl<AuthLocalDataSource>(),
      remoteDataSource: sl<AuthRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    );
  });

  // for the usecases
  sl.registerFactory<Signup>(() => Signup(sl<AuthRepository>()));
  sl.registerFactory<Login>(() => Login(sl<AuthRepository>()));
  sl.registerFactory<SigninWithGoogle>(
      () => SigninWithGoogle(sl<AuthRepository>()));
  sl.registerFactory<LogOut>(() => LogOut(sl<AuthRepository>()));
// for the bloc
  sl.registerFactory<AuthBloc>(() => AuthBloc(
        login: sl<Login>(),
        signup: sl<Signup>(),
        signinWithGooogle: sl<SigninWithGoogle>(),
        logOut: sl<LogOut>(),
      ));
}