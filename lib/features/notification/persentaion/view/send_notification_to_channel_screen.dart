import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/helper/snackbar.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/features/notification/controller/send_notification_controller.dart';
import 'package:notify/features/notification/persentaion/bloc/send_notification_bloc.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/presentaion/controller.dart';
import 'package:notify/shared/presentaion/widget/custom_button.dart';
import 'package:notify/shared/presentaion/widget/custom_text_form_field.dart';

class SendNotificationScreen extends StatefulWidget {
  final Channel channel; // The selected channel's ID

  const SendNotificationScreen({super.key, required this.channel});

  @override
  SendNotificationScreenState createState() => SendNotificationScreenState();
}

class SendNotificationScreenState extends State<SendNotificationScreen> {
  late SendNotificationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SendNotificationController(channel: widget.channel);
  }

  @override
  Widget build(BuildContext context) {
    AppUIController appUIController = AppUIController();
    return BlocProvider(
      create: (context) => sl<SendNotificationBloc>(),
      child: BlocListener<SendNotificationBloc, SendNotificationState>(
        listener: (context, state) {
          if (state is SendNotificationSuccess) {
            ShowSnackBar.successSnackBar(
                context, "Notification Sent Successfully");
            _controller.messageController.clear();
            Navigator.pop(context);
          }
          if (state is SendNotificationFailed) {
            Navigator.pop(context);
            ShowSnackBar.errorSnackBar(context, "Failed to send notification");
          }
        },
        child: BlocBuilder<SendNotificationBloc, SendNotificationState>(
          builder: (context, state) {
            return SafeArea(
              child: Scaffold(
                body: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: appUIController.widgetsWidth,
                    child: Form(
                      key: _controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: appUIController.smallPaddingSpace),
                          Text(
                            widget.channel.title,
                            style: AppTextStyle.xLargeBlackBold,
                          ),
                          SizedBox(height: appUIController.smallPaddingSpace),
                          CustomTextFormField(
                              labelText: "Notification Message",
                              hintText: "Enter your message here",
                              textController: _controller.messageController,
                              validator: (String? value) =>
                                  _controller.messageValidator(value, context)),
                          const Spacer(),
                          ButtonWidget(
                            text: "Send",
                            onPressed: () =>
                                _controller.sendNotification(context),
                          ),
                          SizedBox(
                            height: appUIController.smallPaddingSpace,
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
