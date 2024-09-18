import 'package:notify/features/channel/domin/usecases/add_supervisor.dart';
import 'package:notify/features/channel/domin/usecases/create_channel.dart';
import 'package:notify/features/channel/domin/usecases/join_channel.dart';
import 'package:notify/features/channel/domin/usecases/leave_channel.dart';

abstract class ChannelRemoteDataSource {
  // Channel monopilation
  Future<void> createChannel(CreateChannelParams params);
  Future<void> leaveChannel(LeaveChannelParams params);
  Future<void> joinChannel(JoinChannelParams params);
  Future<void> addSupervisorChannel(AddSupervisorParams params);
}