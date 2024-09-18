import 'package:flutter/material.dart';
import 'package:notify/features/channel/presentation/controllers/channel_controller.dart';
import 'package:notify/shared/presentaion/widget/custom_text_form_field.dart';

class ChannelDescriptionField extends StatelessWidget {
  const ChannelDescriptionField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ChannelController();
    return CustomTextFormField(
      maxLines: 3,
      maxLenght: 39,
      labelText: "Description",
      textController: ChannelController.descriptionController,
      validator: (String? value) =>
          controller.descriptionValidator(value, context),
    );
  }
}