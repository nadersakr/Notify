import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/search/domin/repositories/search_repository.dart';
import 'package:notify/shared/domin/models/channel_model.dart';

class SearchForChannel extends UseCase<List<Channel>, SearchForChannelParams> {
  final SearchRepository repository;

  SearchForChannel(this.repository);

  @override
  Future<Either<Failure, List<Channel>>> call(
      SearchForChannelParams params) async {
    final result = await repository.searchForChannel(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}

class SearchForChannelParams {
  final String query;
  const SearchForChannelParams({
    required this.query,
  });
}
