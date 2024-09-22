part of 'channel_bloc.dart';

sealed class ChannelState extends Equatable {
  const ChannelState();

  @override
  List<Object> get props => [];
}

final class ChannelInitial extends ChannelState {}

final class SendNotificationLoading extends ChannelState {}

final class SendNotificationFailed extends ChannelState {
  final String errorMessage;
  const SendNotificationFailed(this.errorMessage);
}

final class SendNotificationSucess extends ChannelState {}

// create channel states
final class CreateChannelLoading extends ChannelState {}

final class CreateChannelSuccess extends ChannelState {}

final class CreateChannelFailed extends ChannelState {
  final String errorMessage;
  const CreateChannelFailed(this.errorMessage);
}

// join channel states
final class ChannelManipulationFailed extends ChannelState {
  final String errorMessage;
  const ChannelManipulationFailed(this.errorMessage);
}

final class ChannelManipulationLoading extends ChannelState {}

final class ChannelManipulationSucess extends ChannelState {
  final String message;
  const ChannelManipulationSucess(this.message);
}
