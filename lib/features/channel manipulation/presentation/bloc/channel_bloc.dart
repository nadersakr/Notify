import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/create_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/send_notification.dart';
import 'package:notify/features/channel%20manipulation/presentation/controllers/channel_controller.dart';

part 'channel_event.dart';
part 'channel_state.dart';

class ChannelBloc extends Bloc<ChannelEvent, ChannelState> {
  final CreateChannel createChannel;
  final SendNotification sendNotifaction;
  ChannelBloc({
    required this.createChannel,
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
