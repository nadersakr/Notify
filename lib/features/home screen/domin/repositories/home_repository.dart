import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';

abstract class HomeRepository {
Future<Either<Failure,List<Channel>>> getBiggestChannels();
}