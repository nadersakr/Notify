import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/network/network_info.dart';
import 'package:notify/features/search/data/data%20source/remote/remote_data_source.dart';
import 'package:notify/features/search/domin/repositories/search_repository.dart';
import 'package:notify/features/search/domin/usecases/search.dart';
import 'package:notify/shared/domin/entities/group_model.dart';

class SearchRepositoryImpl implements SearchForGroupRepository {
  final SearchRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  const SearchRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<Channal>>> searchForGroup(
      SearchForGroupParams params) async {
    if (await networkInfo.isConnected) {
      try {
        List<Channal> groups = await remoteDataSource.searchForGroup(params);
        return Right(groups);
      } catch (e) {
        return Left(UnknowFailure("Error Occured:$e"));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
