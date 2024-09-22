import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/home%20screen/domin/repositories/home_repository.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';

class GetBiggestChannels extends UseCase<List<Channel>, NoParams> {
  final HomeRepository repository;

  GetBiggestChannels(this.repository);

  @override
  Future<Either<Failure, List<Channel>>> call(NoParams params) async {
    final result = await repository.getBiggestChannels();
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}

