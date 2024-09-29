import 'package:flutter/material.dart';
import 'package:notify/features/notification/controller/send_notification_controller.dart';
import 'package:notify/shared/presentaion/widget/custom_text_form_field.dart';

class SendNotificationScreen extends StatefulWidget {
  final String channelId; // The selected channel's ID

  const SendNotificationScreen({super.key, required this.channelId});

  @override
  _SendNotificationScreenState createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  late SendNotificationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SendNotificationController(channelId: widget.channelId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Notification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _controller.formKey,
          child: Column(
            children: [
              CustomTextFormField(
                labelText: "Notification Title",
                hintText: "Enter notification title",
                textController: _controller.titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                labelText: "Notification Message",
                hintText: "Enter your message here",
                textController: _controller.messageController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Message cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _controller.sendNotification(context),
                child: Text('Send Notification'),
              ),
              if (_controller.isSending)
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
