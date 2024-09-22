part of 'channel_bloc.dart';
sealed class ChannelEvent extends Equatable {
  const ChannelEvent();
  @override
  List<Object> get props => [];
}
class CreateChannelEvent extends ChannelEvent {
  final CreateChannelParams params;
  const CreateChannelEvent({required this.params});
}
class SendNotificationEvent extends ChannelEvent {
  final SendNotificationParams params;
  const SendNotificationEvent({required this.params});
}
