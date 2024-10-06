import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/shared/domin/models/user_model.dart';
import 'package:notify/shared/presentaion/controller.dart';

class UserOverviewContainer extends StatelessWidget {
  const UserOverviewContainer({
    super.key,
    this.height,
    required this.user,
    this.letterSpace,
  });

  final UserModel user;
  final double? height;
  final double? letterSpace;

  @override
  Widget build(BuildContext context) {
    AppUIController appUIController = AppUIController();
    return Container(
      height: height ?? 60.h,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: appUIController.borderWidth),
        borderRadius: appUIController.borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                user.fullName,
                textAlign: TextAlign.left,
                style: AppTextStyle.smallBoldBlack.copyWith(
                  letterSpacing: letterSpace ?? 1.5.sp,
                ),
              ),
              const Spacer(),
              const Icon(
                Iconsax.user,
                size: 18,
              )
            ],
          ),
          Text(
            user.email.length > 50
                ? '${user.email.substring(0, 50)}'
                    '..'
                : user.email,
            style: AppTextStyle.smallBlack,
          )
        ],
      ),
    );
  }
}
