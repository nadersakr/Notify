part of 'channel_bloc.dart';

sealed class ChannelState extends Equatable {
  const ChannelState();

  @override
  List<Object> get props => [];
}

final class ChannelInitial extends ChannelState {}

final class CreateChannelLoading extends ChannelState {}

final class CreateChannelSuccess extends ChannelState {}

final class CreateChannelFailed extends ChannelState {
  final String errorMessage;
  const CreateChannelFailed(this.errorMessage);
}
