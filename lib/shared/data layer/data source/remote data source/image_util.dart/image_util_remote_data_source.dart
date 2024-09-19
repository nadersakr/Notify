import 'dart:io';

import 'package:notify/shared/domin/usecases/compress_image_usecase.dart';
import 'package:notify/shared/domin/usecases/upload_image_usecase.dart';

abstract class ImageUtilRemoteDataSource {
  Future<String> uploadImageAndGetUrl(UploadImageParams params);
  Future<File> compressImage(CompressImageParams params);
  
}
