import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/network/network_info.dart';
import 'package:notify/shared/data%20layer/data%20source/remote%20data%20source/image_util.dart/image_util_remote_data_source.dart';
import 'package:notify/shared/domin/repositories/Image_util_repository.dart';
import 'package:notify/shared/domin/usecases/compress_image_usecase.dart';
import 'package:notify/shared/domin/usecases/upload_image_usecase.dart';

class ImageUtilRepositoryImpl extends ImageUtilRepository {
  final NetworkInfo networkInfo;
  final ImageUtilRemoteDataSource remoteDataSource;
  ImageUtilRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, File>> compressImage(CompressImageParams params) async {
    if (await networkInfo.isConnected) {
      try {
        File compressedImage = await remoteDataSource.compressImage(params);
        return Right(compressedImage);
      } catch (e) {
        return const Left(ImageUtilFailure("Error compressing image"));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage(UploadImageParams params) async {
    if (await networkInfo.isConnected) {
      try {
        String url = await remoteDataSource.uploadImageAndGetUrl(params);
        return Right(url);
      } catch (e) {
        return const Left(ImageUtilFailure("Error uploading image"));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
