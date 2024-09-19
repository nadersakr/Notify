import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/shared/data%20layer/data%20source/remote%20data%20source/image_util.dart/image_util_remote_data_source.dart';
import 'package:notify/shared/domin/usecases/compress_image_usecase.dart';
import 'package:notify/shared/domin/usecases/upload_image_usecase.dart';

class ImageUtilRemoteDataSourceImpl extends ImageUtilRemoteDataSource {
  @override
  Future<File> compressImage(CompressImageParams params) async {
    try {
      final compressedImage = await FlutterImageCompress.compressWithFile(
        params.image.absolute.path,
        minWidth: 600,
        minHeight: 500,
        quality: 75,
      );

      if (compressedImage == null) {
        throw const ImageUtilFailure('Failed to compress image');
      }

      final compressedImageFile = File(
        '${params.image.parent.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await compressedImageFile.writeAsBytes(compressedImage);

      return compressedImageFile;
    } catch (e) {
      throw const ImageUtilFailure('Failed to compress image');
    }
  }

  @override
  Future<String> uploadImageAndGetUrl(UploadImageParams params) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('uploads/${params.image.uri.pathSegments.last}');
      await storageRef.putFile(params.image);
      return await storageRef.getDownloadURL();
    } catch (e) {
      throw const ImageUtilFailure('Error uploading image');
    }
  }
}
