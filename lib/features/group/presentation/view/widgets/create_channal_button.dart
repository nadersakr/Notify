import 'package:flutter/material.dart';
import 'package:notify/shared/presentaion/widget/custom_button.dart';
import 'package:notify/features/group/presentation/controllers/channal_controller.dart';

class CreateChannelButton extends StatelessWidget {
  const CreateChannelButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ChannalController();
    return ButtonWidget(
      text: "Create Channel",
      onPressed: () => controller.createChannel(context),
    );
  }
}
