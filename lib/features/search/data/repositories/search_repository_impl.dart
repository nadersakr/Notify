import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/network/network_info.dart';
import 'package:notify/features/search/data/data%20source/remote/remote_data_source.dart';
import 'package:notify/features/search/domin/repositories/search_repository.dart';
import 'package:notify/features/search/domin/usecases/search.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';

class SearchRepositoryImpl implements SearchForChannelRepository {
  final SearchRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  const SearchRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<Channel>>> searchForChannel(
      SearchForChannelParams params) async {
    if (await networkInfo.isConnected) {
      try {
        List<Channel> channels = await remoteDataSource.searchForChannel(params);
        return Right(channels);
      } catch (e) {
        return Left(UnknowFailure("Error Occured:$e"));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
