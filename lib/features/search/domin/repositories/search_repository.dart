import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/features/search/domin/usecases/search_for_channel.dart';
import 'package:notify/features/search/domin/usecases/search_for_user.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/domin/entities/user_model.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Channel>>> searchForChannel(
      SearchForChannelParams params);
  Future<Either<Failure, List<UserModel>>> searchForUser(
      SearchForUserParams params);
}
