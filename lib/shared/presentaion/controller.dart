import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppUIController with Sizes {
  BorderRadius borderRadius = BorderRadius.all(Radius.circular(15.sp));
  BorderRadius toFitborderRadius = BorderRadius.all(Radius.circular(16.sp));
  BorderRadius textFormFieldborderRadius =
      BorderRadius.all(Radius.circular(12.sp));
}

mixin Sizes {
  final double smallPaddingSpace = 0.05.sw;

  final double widgetsWidth = 0.9.sw;
  double get letterSpace => 1.5.sp;
  double borderWidth = 1.0.sp;
}
