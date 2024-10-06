import 'package:notify/features/search/domin/usecases/search_for_channel.dart';
import 'package:notify/features/search/domin/usecases/search_for_user.dart';
import 'package:notify/shared/domin/models/channel_model.dart';
import 'package:notify/shared/domin/models/user_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<Channel>> searchForChannel(SearchForChannelParams params);
  Future<List<UserModel>> searchForUser(SearchForUserParams params);
}
