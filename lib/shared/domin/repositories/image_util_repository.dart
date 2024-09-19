import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/shared/domin/usecases/compress_image_usecase.dart';
import 'package:notify/shared/domin/usecases/upload_image_usecase.dart';

abstract class ImageUtilRepository {
    Future<Either<Failure,String>> uploadImage(UploadImageParams params);
    Future<Either<Failure,File>> compressImage(CompressImageParams params);

}