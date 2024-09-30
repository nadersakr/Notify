part of 'send_notification_bloc.dart';

sealed class SendNotificationState extends Equatable {
  const SendNotificationState();

  @override
  List<Object> get props => [];
}

final class SendNotificationInitial extends SendNotificationState {}

final class SendNotificationLoading extends SendNotificationState {}

final class SendNotificationSuccess extends SendNotificationState {}

final class SendNotificationFailed extends SendNotificationState {
  final String errorMessage;
  const SendNotificationFailed(this.errorMessage);
}
