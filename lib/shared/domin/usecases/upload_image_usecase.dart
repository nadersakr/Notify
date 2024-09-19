import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/shared/domin/repositories/Image_util_repository.dart';

class UploadImage extends UseCase<String, UploadImageParams> {
  final ImageUtilRepository repository;

  UploadImage(this.repository);

  @override
  Future<Either<Failure, String>> call(UploadImageParams params) async {
    final result = await repository.uploadImage(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}

class UploadImageParams {
  final File image;
  const UploadImageParams({
    required this.image,
  });
}
