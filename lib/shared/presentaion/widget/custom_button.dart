import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notify/core/style/app_colors.dart';
import 'package:notify/core/style/app_text_style.dart';

class ButtonWidget extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final double? radius;
  final double? buttonWidth;
  final double? buttonHeight;
  final Function()? onPressed;

  const ButtonWidget({
    super.key,
    required this.text,
    this.textStyle,
    this.backgroundColor,
    this.radius,
    this.buttonWidth,
    this.buttonHeight,
    this.onPressed,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = AppTextStyle.largeBlack.copyWith(
      fontWeight: FontWeight.bold,
    );

    return InkWell(
      onTap: widget.onPressed ?? () {},
      child: Container(
        width: widget.buttonWidth ?? 0.9.sw,
        height: widget.buttonHeight ?? 50.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(
            widget.radius ?? 15.sp,
          ),
          gradient: const LinearGradient(
            colors: [
              AppColors.primaryColor,
              AppColors.primaryColorDarker,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Text(
          widget.text,
          style: widget.textStyle ?? textStyle,
        ),
      ),
    );
  }
}
