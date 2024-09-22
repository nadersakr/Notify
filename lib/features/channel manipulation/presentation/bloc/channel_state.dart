part of 'channel_bloc.dart';

sealed class ChannelState extends Equatable {
  const ChannelState();

  @override
  List<Object> get props => [];
}

final class ChannelInitial extends ChannelState {}

final class CreateChannelLoading extends ChannelState {}

final class SendNotificationLoading extends ChannelState {}

final class SendNotificationSucess extends ChannelState {
  
}

final class SendNotificationFailed extends ChannelState {
  final String errorMessage;
  const SendNotificationFailed(this.errorMessage);
}

final class CreateChannelSuccess extends ChannelState {}

final class CreateChannelFailed extends ChannelState {
  final String errorMessage;
  const CreateChannelFailed(this.errorMessage);
}
