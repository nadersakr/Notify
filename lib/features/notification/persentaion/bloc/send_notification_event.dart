part of 'send_notification_bloc.dart';

sealed class SendNotificationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendNotificationMainEvent extends SendNotificationEvent {
  final SendNotificationParams params;
  SendNotificationMainEvent(this.params);
}
