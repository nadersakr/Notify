import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/create_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/delete_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/join_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/leave_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/send_notification.dart';
import 'package:notify/features/channel%20manipulation/presentation/controllers/channel_controller.dart';

part 'channel_event.dart';
part 'channel_state.dart';

class ChannelBloc extends Bloc<ChannelEvent, ChannelState> {
  final CreateChannel createChannel;
  final SendNotification sendNotifaction;
  final JoinChannel joinChannel;
  final LeaveChannel leaveChannel;
  final DeleteChannel deleteChannel;
  ChannelBloc({
    required this.createChannel,
    required this.joinChannel,
    required this.deleteChannel,
    required this.leaveChannel,
    required this.sendNotifaction,
  }) : super(ChannelInitial()) {
    on<CreateChannelEvent>((event, emit) async {
      emit(CreateChannelLoading());
      final result = await createChannel.call(event.params);
      result.fold((l) {
        emit(CreateChannelFailed(l.errorMessage));
      }, (r) {
        ChannelController.resetParamters();
        emit(CreateChannelSuccess());
      });
    });
    on<JoinChannelEvent>((event, emit) async {
      emit(ChannelManipulationLoading());
      final result = await joinChannel.call(event.params);
      result.fold((l) {
        print(l.errorMessage);
        emit(ChannelManipulationFailed(l.errorMessage));
      }, (r) {
        print("joined");
        emit(const ChannelManipulationSucess("You have joined the channel"));
      });
    });
    on<LeaveChannelEvent>((event, emit) async {
      emit(ChannelManipulationLoading());
      final result = await leaveChannel.call(event.params);
      result.fold((l) {
        emit(ChannelManipulationFailed(l.errorMessage));
      }, (r) {
        emit(const ChannelManipulationSucess("You have left the channel"));
      });
    });
    on<DeleteChannelEvent>((event, emit) async {
      emit(ChannelManipulationLoading());
      final result = await deleteChannel.call(event.params);
      result.fold((l) {
        emit(ChannelManipulationFailed(l.errorMessage));
      }, (r) {
        print("Deleted");
        emit(const ChannelManipulationSucess("Channel has been deleted"));
      });
    });
    on<SendNotificationEvent>((event, emit) async {
      print("send notification event");
      emit(SendNotificationLoading());
      final result = await sendNotifaction.call(event.params);
      result.fold((l) {
        emit(SendNotificationFailed(l.errorMessage));
      }, (r) {
        emit(SendNotificationSucess());
      });
    });
  }
}
