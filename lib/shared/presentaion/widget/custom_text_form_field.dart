import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notify/core/style/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final double? borderRadius;
  final TextEditingController? textController;
  final Color? borderColor;
  final Color? errorBorderColor;
  final double? borderwidth;
  final IconData? suffixIcon;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final void Function()? onIconPressed;
  const CustomTextFormField(
      {super.key,
      this.hintText,
      this.labelText,
      this.borderRadius,
      this.borderColor,
      this.borderwidth,
      this.errorBorderColor,
      this.suffixIcon,
      this.obscureText,
      this.onIconPressed,
      this.validator, this.textController});
  InputBorder border({Color? color}) => OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 15.sp)),
        borderSide: BorderSide(
            color: borderColor ?? AppColors.primaryColor,
            width: borderwidth ?? 1.5.w),
      );
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      key: key,
      validator: validator,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        suffixIcon: IconButton(
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
