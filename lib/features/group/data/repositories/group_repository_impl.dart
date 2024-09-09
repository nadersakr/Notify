import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/network/network_info.dart';
import 'package:notify/features/group/data/data%20source/remote/remote_data_source.dart';
import 'package:notify/features/group/domin/repositories/group_repository.dart';
import 'package:notify/features/group/domin/usecases/add_supervisor.dart';
import 'package:notify/features/group/domin/usecases/create_group.dart';
import 'package:notify/features/group/domin/usecases/join_group.dart';
import 'package:notify/features/group/domin/usecases/leave_group.dart';

class GroupRepositoryImpl implements GroupRepository {
  final GroupRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  const GroupRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, void>> addSupervisor(
      AddSupervisorParams params) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addSupervisorGroup(params);
        return const Right(Void);
      } catch (e) {
        return Left(UnknowFailure("Error Occured:$e"));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> createGroup(CreateGroupParams params) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.createGroup(params);
        return const Right(Void);
      } catch (e) {
        return Left(UnknowFailure("Error Occured:$e"));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> joinGroup(JoinGroupParams params) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.joinGroup(params);
        return const Right(Void);
      } catch (e) {
        return Left(UnknowFailure("Error Occured:$e"));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> leaveGroup(LeaveGroupParams params) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.leaveGroup(params);
        return const Right(Void);
      } catch (e) {
        return Left(UnknowFailure("Error Occured:$e"));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
