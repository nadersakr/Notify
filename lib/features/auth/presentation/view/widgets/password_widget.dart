import 'package:flutter/material.dart';
import 'package:notify/features/auth/presentation/controllers/auth_view_model.dart';
import 'package:notify/shared/presentaion/widget/custom_text_form_field.dart';

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({
    super.key,
    required this.controller,
    this.isConfirmPassword = false,
    this.validator,
    this.textController,
  });
  final bool isConfirmPassword;
  final AuthViewModel controller;
  final TextEditingController? textController;
  final String? Function(String?)? validator;
  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      maxLines: null,
      // key: widget.key,
      textController: widget.textController,
      validator: widget.validator,
      obscureText: widget.isConfirmPassword
          ? widget.controller.isConfirmedPasswordVisible
          : widget.controller.isPasswordVisible,
      onIconPressed: () {
        setState(() {
          widget.controller.showPassword(widget.isConfirmPassword);
        });
      },
      hintText: !widget.isConfirmPassword
          ? widget.controller.passwordString
          : widget.controller.confirmPasswordString,
      labelText: !widget.isConfirmPassword
          ? widget.controller.passwordLabel
          : widget.controller.confirmPasswordLable,
      suffixIcon: widget.controller.passwordIcon,
    );
  }
}
