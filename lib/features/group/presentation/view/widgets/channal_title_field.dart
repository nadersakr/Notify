import 'package:flutter/material.dart';
import 'package:notify/features/group/presentation/controllers/channal_controller.dart';
import 'package:notify/shared/presentaion/widget/custom_text_form_field.dart';

class ChannelTitleField extends StatelessWidget {
  const ChannelTitleField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ChannalController();
    return CustomTextFormField(
      maxLenght: 19,
      labelText: "Title",
      textController: ChannalController.titleController,
      validator: (String? value) => controller.titleValidator(value, context),
    );
  }
}