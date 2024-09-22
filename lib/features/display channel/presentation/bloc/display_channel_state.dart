part of 'display_channel_bloc.dart';

sealed class DisplayChannelState extends Equatable {
  const DisplayChannelState();
  
  @override
  List<Object> get props => [];
}

final class DisplayChannelInitial extends DisplayChannelState {}
final class DisplayChannelLoading extends DisplayChannelState {}
final class DisplayChannelLoaded extends DisplayChannelState {
  final Channel channel;
  const DisplayChannelLoaded(this.channel);
}
final class DisplayChannelFailed extends DisplayChannelState {
  final String errorMessage;
  const DisplayChannelFailed(this.errorMessage);
}
