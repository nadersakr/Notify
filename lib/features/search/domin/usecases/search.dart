import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/search/domin/repositories/search_repository.dart';
import 'package:notify/shared/domin/entities/group_model.dart';

class SearchForGroup extends UseCase<List<Group>, SearchForGroupParams> {
  final SearchForGroupRepository repository;

  SearchForGroup(this.repository);

  @override
  Future<Either<Failure, List<Group>>> call(SearchForGroupParams params) async {
    final result = await repository.searchForGroup(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      
      return Right(r);
    });
  }
}

class SearchForGroupParams {
  final String query;
  const SearchForGroupParams({
    required this.query,
  });
}
