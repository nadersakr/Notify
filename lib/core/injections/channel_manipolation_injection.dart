import 'package:notify/core/app_injection.dart';
import 'package:notify/core/network/network_info.dart';
import 'package:notify/core/utils/services/firebase%20services/notification%20services/notification_base_class.dart';
import 'package:notify/features/channel%20manipulation/data/data%20source/remote/remote_data_source.dart';
import 'package:notify/features/channel%20manipulation/data/data%20source/remote/remote_data_source_impl.dart';
import 'package:notify/features/channel%20manipulation/data/repositories/channel_repository_impl.dart';
import 'package:notify/features/channel%20manipulation/domin/repositories/channel_repository.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/add_supervisor.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/create_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/delete_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/join_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/leave_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/send_notification.dart';
import 'package:notify/features/channel%20manipulation/presentation/bloc/channel_bloc.dart';

channelFeatureInjection() async {
  sl.registerFactory<ChannelRemoteDataSource>(
      () => ChannelRemoteDataSourceImpl(notificationService: sl<NotificationService >()));

  sl.registerSingletonAsync<ChannelRepository>(() async {
    return ChannelRepositoryImpl(
        networkInfo: sl<NetworkInfo>(),
        remoteDataSource: sl<ChannelRemoteDataSource>());
  });
  sl.registerFactory<CreateChannel>(
      () => CreateChannel(sl<ChannelRepository>()));
  sl.registerFactory<LeaveChannel>(() => LeaveChannel(sl<ChannelRepository>()));
  sl.registerFactory<SendNotification>(
      () => SendNotification(sl<ChannelRepository>()));
  sl.registerFactory<DeleteChannel>(
      () => DeleteChannel(sl<ChannelRepository>()));
  sl.registerFactory<JoinChannel>(() => JoinChannel(sl<ChannelRepository>()));
  sl.registerFactory<AddSupervisorChannel>(
      () => AddSupervisorChannel(sl<ChannelRepository>()));
  sl.registerFactory<ChannelBloc>(() => ChannelBloc(
      addSupervisorChannel: sl<AddSupervisorChannel>(),
      joinChannel: sl<JoinChannel>(),
      createChannel: sl<CreateChannel>(),
      sendNotifaction: sl<SendNotification>(),
      leaveChannel: sl<LeaveChannel>(),
      deleteChannel: sl<DeleteChannel>()));
}