import 'package:flutter/material.dart';
import 'package:notify/core/style/app_colors.dart';

class BorderContainer extends StatelessWidget {
  const BorderContainer({
    super.key,
    required this.child,
    this.height,
    this.color,
  });

  final Widget child;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: color ?? AppColors.primaryColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
