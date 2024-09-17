import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppUIController with Sizes {}

mixin Sizes {
  final double smallPaddingSpace = 0.05.sw;

  final double widgetsWidth = 0.9.sw;
  double get letterSpace => 1.5.sp;
}
