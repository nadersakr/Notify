import 'package:notify/features/channel%20manipulation/domin/usecases/add_supervisor.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/create_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/join_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/leave_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/send_notification.dart';

abstract class ChannelRemoteDataSource {
  // Channel monopilation
  Future<void> createChannel(CreateChannelParams params);
  Future<void> leaveChannel(LeaveChannelParams params);
  Future<void> joinChannel(JoinChannelParams params);
  Future<void> addSupervisorChannel(AddSupervisorParams params);
  Future<void> sendNotification(SendNotificationParams params);
}