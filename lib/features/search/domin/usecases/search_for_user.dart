import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/search/domin/repositories/search_repository.dart';
import 'package:notify/shared/domin/entities/user_model.dart';

class SearchForUser extends UseCase<List<UserModel>, SearchForUserParams> {
  final SearchRepository repository;

  SearchForUser(this.repository);

  @override
  Future<Either<Failure, List<UserModel>>> call(
      SearchForUserParams params) async {
    final result = await repository.searchForUser(params);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}

class SearchForUserParams {
  final String query;
  const SearchForUserParams({
    required this.query,
  });
}
