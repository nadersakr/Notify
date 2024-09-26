import 'package:notify/core/app_injection.dart';
import 'package:notify/core/network/network_info.dart';
import 'package:notify/features/search/data/data%20source/remote/remote_data_source.dart';
import 'package:notify/features/search/data/data%20source/remote/remote_data_source_impl.dart';
import 'package:notify/features/search/data/repositories/search_repository_impl.dart';
import 'package:notify/features/search/domin/repositories/search_repository.dart';
import 'package:notify/features/search/domin/usecases/search_for_channel.dart';
import 'package:notify/features/search/domin/usecases/search_for_user.dart';
import 'package:notify/features/search/presentation/bloc/search_bloc.dart';

searchBlocInjections() async {
  // I need to make one inssatnce of the bloc
  sl.registerFactory<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl());
  sl.registerFactory<SearchRepository>(() => SearchRepositoryImpl(
      remoteDataSource: sl<SearchRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>()));
  sl.registerFactory<SearchForChannel>(
      () => SearchForChannel(sl<SearchRepository>()));
  sl.registerFactory<SearchForUser>(
      () => SearchForUser(sl<SearchRepository>()));
  sl.registerFactory<SearchBloc>(() => SearchBloc(
      searchForChannel: sl<SearchForChannel>(),
      searchForUser: sl<SearchForUser>()));
}