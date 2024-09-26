import 'package:notify/core/app_injection.dart';
import 'package:notify/core/network/network_info.dart';
import 'package:notify/shared/data%20layer/data%20source/remote%20data%20source/image_util.dart/image_util_remote_data_source.dart';

import 'package:notify/shared/data%20layer/data%20source/remote%20data%20source/image_util.dart/image_util_remote_data_source_impl.dart';

import 'package:notify/shared/data%20layer/repositories/image_util_repository_impl.dart';

import 'package:notify/shared/domin/repositories/Image_util_repository.dart';

import 'package:notify/shared/domin/usecases/compress_image_usecase.dart';

import 'package:notify/shared/domin/usecases/upload_image_usecase.dart';

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