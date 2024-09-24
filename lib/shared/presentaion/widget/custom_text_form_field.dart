import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notify/core/style/app_colors.dart';
import 'package:notify/shared/presentaion/controller.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final int? maxLines;
  final double? borderRadius;
  final TextEditingController? textController;
  final Color? borderColor;
  final Color? errorBorderColor;
  final double? borderwidth;
  final int? maxLenght;
  final IconData? suffixIcon;
  final Widget? suffixWidget;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final void Function()? onIconPressed;
  final void Function(String)? onchanged;
  final void Function(String)? onSubmitted;
  const CustomTextFormField(
      {super.key,
      this.maxLines,
      this.hintText,
      this.maxLenght,
      this.labelText,
      this.borderRadius,
      this.borderColor,
      this.borderwidth,
      this.errorBorderColor,
      this.suffixIcon,
      this.obscureText,
      this.onIconPressed,
      this.validator,
      this.textController,
      this.suffixWidget,
      this.onchanged,
      this.onSubmitted});
  InputBorder border({Color? color}) => OutlineInputBorder(
        borderRadius: borderRadius != null
            ? BorderRadius.all(Radius.circular(borderRadius ?? 15.sp))
            : AppUIController().textFormFieldborderRadius,
        borderSide: BorderSide(
            color: borderColor ?? AppColors.primaryColor,
            width: borderwidth ?? AppUIController().borderWidth),
      );
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      minLines: 1,
      maxLength: maxLenght,
      onChanged: onchanged,
      onFieldSubmitted: onSubmitted,
      controller: textController,
      key: key,
      validator: validator,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        counterText: "",
        contentPadding: const EdgeInsets.all(10),
        suffixIcon: suffixWidget ??
            IconButton(
              onPressed: onIconPressed,
              icon: Icon(suffixIcon),
              disabledColor: Colors.black,
            ),
        hintText: hintText,
        labelText: labelText,
        focusedBorder: border(color: borderColor),
        enabledBorder: border(color: borderColor),
        border: border(color: borderColor),
        errorBorder: border(color: borderColor),
      ),
    );
  }
}
