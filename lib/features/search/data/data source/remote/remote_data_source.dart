import 'package:notify/features/search/domin/usecases/search.dart';
import 'package:notify/shared/domin/entities/group_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<Channel>> searchForGroup(SearchForGroupParams params);
}
