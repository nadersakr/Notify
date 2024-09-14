import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/features/search/domin/usecases/search.dart';
import 'package:notify/shared/domin/entities/group_model.dart';

abstract class SearchForGroupRepository {
  Future<Either<Failure, List<Channal>>> searchForGroup(
      SearchForGroupParams params);
}
