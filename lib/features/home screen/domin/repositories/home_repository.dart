import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/shared/domin/usecases/get_user_info.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/domin/entities/user_model.dart';

abstract class HomeRepository {
Future<Either<Failure,List<Channel>>> getBiggestChannels();
Future<Either<Failure,UserModel>> getUserData(GetUserInfoParams params);
}