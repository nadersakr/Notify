import 'package:flutter/material.dart';
import 'package:notify/features/group/presentation/controllers/channal_controller.dart';
import 'package:notify/shared/presentaion/widget/custom_text_form_field.dart';

class ChannelDescriptionField extends StatelessWidget {
  const ChannelDescriptionField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ChannalController();
    return CustomTextFormField(
      maxLines: 3,
      maxLenght: 39,
      labelText: "Description",
      textController: ChannalController.descriptionController,
      validator: (String? value) =>
          controller.descriptionValidator(value, context),
    );
  }
}