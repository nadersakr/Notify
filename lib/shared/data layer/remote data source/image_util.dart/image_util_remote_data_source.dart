import 'dart:io';

abstract class ImageUtilRemoteDataSource {
  Future<String> uploadImageAndGetUrl(File image);
  Future<File> compressImage(File image);
  
}
