import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/features/search/domin/usecases/search.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';

abstract class SearchForChannelRepository {
  Future<Either<Failure, List<Channel>>> searchForChannel(
      SearchForChannelParams params);
}
