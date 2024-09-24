import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/shared/domin/usecases/get_user_info.dart';
import 'package:notify/shared/domin/entities/user_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure,UserModel>> getUserInfo(GetUserInfoParams params);
}
