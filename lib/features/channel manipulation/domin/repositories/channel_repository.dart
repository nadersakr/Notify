import 'package:dartz/dartz.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/add_supervisor.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/create_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/join_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/leave_channel.dart';

abstract class ChannelRepository {
  Future<Either<Failure,void>> createChannel(CreateChannelParams params);
  Future<Either<Failure,void>> leaveChannel(LeaveChannelParams params);
  Future<Either<Failure,void>> joinChannel(JoinChannelParams params);
  Future<Either<Failure,void>> addSupervisor(AddSupervisorParams params);
}
