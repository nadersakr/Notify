import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/utils/lottle/lottle.dart';
import 'package:notify/core/utils/validators/base_validator.dart';
import 'package:notify/core/utils/validators/less_than.dart';
import 'package:notify/core/utils/validators/longer_than_chars.dart';
import 'package:notify/core/utils/validators/required_validator.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/send_notification.dart';
import 'package:notify/features/channel%20manipulation/presentation/bloc/channel_bloc.dart';
import 'package:notify/features/notification/persentaion/bloc/send_notification_bloc.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/domin/entities/notification_model.dart';
class SendNotificationController {
  final Channel channel;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController messageController = TextEditingController();
  bool isSending = false;

  SendNotificationController({required this.channel});

  Future<void> sendNotification(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
       // Show CircularProgressIndicator
      RunLottleFile().showNotiftyLottle(context, "Sending Notification");
      SendNotificationParams params = SendNotificationParams(channel: channel, notification: NotificationModel(id: "${DateTime.now().millisecondsSinceEpoch}", message: messageController.text, timestamp: DateTime.now()));

          BlocProvider.of<SendNotificationBloc>(context)
              .add(SendNotificationMainEvent(params));

    }
  }


  String? messageValidator(String? value, BuildContext context) =>
      BaseValidator.validateValue(
        context,
        value ?? "",
        [RequiredValidator(), LognerThanChars(2), LessThanChars(50)],
        true,
      );
}
