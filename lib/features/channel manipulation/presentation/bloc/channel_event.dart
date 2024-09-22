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
class JoinChannelEvent extends ChannelEvent {
  final JoinChannelParams params;
  const JoinChannelEvent({required this.params});
}
class LeaveChannelEvent extends ChannelEvent {
  final LeaveChannelParams params;
  const LeaveChannelEvent({required this.params});
}
class DeleteChannelEvent extends ChannelEvent {
  final DeleteChannelParams params;
  const DeleteChannelEvent({required this.params});
}
