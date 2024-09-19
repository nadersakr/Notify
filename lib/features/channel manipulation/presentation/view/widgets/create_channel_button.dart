import 'package:flutter/material.dart';
import 'package:notify/features/channel%20manipulation/presentation/controllers/channel_controller.dart';
import 'package:notify/shared/presentaion/widget/custom_button.dart';

class CreateChannelButton extends StatelessWidget {
  const CreateChannelButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ChannelController();
    return ButtonWidget(
      text: "Create Channel",
      onPressed: () => controller.createChannel(context),
    );
  }
}
