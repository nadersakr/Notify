import 'package:flutter/material.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/utils/services/firebase%20services/notification%20services/firebase_messaging.dart';
import 'package:notify/core/utils/services/firebase%20services/notification%20services/notification_base_class.dart';

class SendNotificationController {
  final String channelId;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  bool isSending = false;

  SendNotificationController({required this.channelId});

  Future<void> sendNotification(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      FirebaseNotificationService firebaseNotificationService =
          FirebaseNotificationService();
      firebaseNotificationService.sendFCMTopicMessage(
        topic: channelId,
        title: titleController.text,
        body: messageController.text,
      );
    }
  }
}
