import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/shared/domin/entities/group_model.dart';

class ChannalOverviewContainer extends StatelessWidget {
  const ChannalOverviewContainer({
    super.key,
    this.height,
    required this.channal,
    this.letterSpace,
  });

  final Channal channal;
  final double? height;
  final double? letterSpace;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60.h,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Color(int.parse('0xFF${channal.hexColor}'))),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                channal.title,
                textAlign: TextAlign.left,
                style: AppTextStyle.smallBoldBlack.copyWith(
                  letterSpacing: letterSpace ?? 1.5.sp,
                ),
              ),
              const Spacer(),
              // member count
              Text("${channal.membersCount}"),

              const Icon(
                Iconsax.user,
                size: 18,
              )
            ],
          ),
          Text(
            channal.describtion.length > 50
                ? '${channal.describtion.substring(0, 50)}'
                    '..'
                : channal.describtion,
            style: AppTextStyle.smallBlack,
          )
        ],
      ),
    );
  }
}
