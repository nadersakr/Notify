import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notify/core/style/app_text_style.dart';

class CreateChannelTitle extends StatelessWidget {
  const CreateChannelTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Create New Channel',
      style: AppTextStyle.xLargeBlack.copyWith(letterSpacing: 1.5.sp),
    );
  }
}