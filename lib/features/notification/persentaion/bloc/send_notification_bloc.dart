import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/send_notification.dart';

part 'send_notification_event.dart';
part 'send_notification_state.dart';

class SendNotificationBloc
    extends Bloc<SendNotificationEvent, SendNotificationState> {
  SendNotification sendNotification;
  SendNotificationBloc({required this.sendNotification})
      : super(SendNotificationInitial()) {
    on<SendNotificationMainEvent>((event, emit) async {
      emit(SendNotificationLoading());
      final result = await sendNotification.call(event.params);
      result.fold((l) {
        emit(SendNotificationFailed(l.errorMessage));
      }, (r) {
        emit(SendNotificationSuccess());
      });
    });
  }
}
