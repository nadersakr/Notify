import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/shared/domin/repositories/Image_util_repository.dart';

class CompressImage extends UseCase<File, CompressImageParams> {
  final ImageUtilRepository repository;

  CompressImage(this.repository);

  @override
  Future<Either<Failure, File>> call(CompressImageParams params) async {
    final result = await repository.compressImage(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}

class CompressImageParams {
  final File image;
  const CompressImageParams({
    required this.image,
  });
}
