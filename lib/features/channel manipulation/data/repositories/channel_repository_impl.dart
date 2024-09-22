import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/network/network_info.dart';
import 'package:notify/features/channel%20manipulation/data/data%20source/remote/remote_data_source.dart';
import 'package:notify/features/channel%20manipulation/domin/repositories/channel_repository.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/add_supervisor.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/create_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/delete_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/join_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/leave_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/send_notification.dart';

class ChannelRepositoryImpl implements ChannelRepository {
  final ChannelRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  const ChannelRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> addSupervisor(
      AddSupervisorParams params) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addSupervisorChannel(params);
        return const Right(unit);
      } catch (e) {
        return Left(UnknowFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> createChannel(
      CreateChannelParams params) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.createChannel(params);
        return const Right(unit);
      } catch (e) {
        return Left(UnknowFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> joinChannel(JoinChannelParams params) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.joinChannel(params);
        return const Right(unit);
      } on FirebaseFailure catch (e) {
        return Left(FirebaseFailure(e.errorMessage));
      } catch (e) {
        return Left(UnknowFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> leaveChannel(LeaveChannelParams params) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.leaveChannel(params);
        return const Right(unit);
      }on FirebaseFailure catch (e) {
        return Left(FirebaseFailure(e.errorMessage));
      }  catch (e) {
        return Left(UnknowFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> sendNotification(
      SendNotificationParams params) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.sendNotification(params);
        return const Right(unit);
      } catch (e) {
        return Left(UnknowFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteChannel(DeleteChannelParams params) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteChannel(params);
        return const Right(unit);
      } catch (e) {
        return Left(UnknowFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
