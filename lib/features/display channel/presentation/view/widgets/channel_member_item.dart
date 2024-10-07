import 'package:flutter/material.dart';
import 'package:notify/features/profile/presentation/view/widgets/user_image_widget.dart';
import 'package:notify/shared/domin/models/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notify/core/style/app_colors.dart';
import 'package:notify/shared/presentaion/controller.dart';

Widget buildMemberItem(UserModel member) {
  return Container(
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
    child: Column(
      children: [
        Container(
                                width: 80.h,
                                height: 80.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: AppUIController().borderWidth,
                                      color: AppColors.primaryColor),
                                  shape: BoxShape.circle,
                                ),
                                child: ImageCircle(
                                  imagePath: member.imageUrl,
                                )
                              ),
        const SizedBox(height: 4),
        Text(
          member.fullName,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
