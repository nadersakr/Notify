import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/features/display%20channel/domin/usecases/load_channel_data.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';

part 'display_channel_event.dart';
part 'display_channel_state.dart';

class DisplayChannelBloc
    extends Bloc<DisplayChannelEvent, DisplayChannelState> {
  final LoadChannelData loadChannelData;

  DisplayChannelBloc({required this.loadChannelData})
      : super(DisplayChannelInitial()) {
    print("DISPLAY CHANNEL BLOC");
    on<GetChannelDataEvent>((event, emit) async {
      print("GET CHANNEL DATA EVENT");
      emit(DisplayChannelLoading());
      Either<Failure, Channel> response =
          await loadChannelData.call(event.params);
      response.fold((l) {
        emit(DisplayChannelFailed(l.errorMessage));
      }, (r) {
        emit(DisplayChannelLoaded(r));
      });
    });
  }
}
