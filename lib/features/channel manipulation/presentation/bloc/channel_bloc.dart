import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/create_channel.dart';
import 'package:notify/features/channel%20manipulation/presentation/controllers/channel_controller.dart';

part 'channel_event.dart';
part 'channel_state.dart';

class ChannelBloc extends Bloc<ChannelEvent, ChannelState> {
  final CreateChannel createChannel;
  ChannelBloc({required this.createChannel}) : super(ChannelInitial()) {
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
  }
}
