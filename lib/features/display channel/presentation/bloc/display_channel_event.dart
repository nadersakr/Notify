part of 'display_channel_bloc.dart';

sealed class DisplayChannelEvent extends Equatable {
  const DisplayChannelEvent();

  @override
  List<Object> get props => [];
}

class GetChannelDataEvent extends DisplayChannelEvent {
  final LoadChannelDataParams params;
  const GetChannelDataEvent(this.params);
}
