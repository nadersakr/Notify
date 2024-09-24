import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/presentaion/controller.dart';

class ChannelOverviewContainer extends StatelessWidget {
  const ChannelOverviewContainer({
    super.key,
    this.height,
    required this.channel,
    this.letterSpace,
  });

  final Channel channel;
  final double? height;
  final double? letterSpace;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60.h,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
            color: Color(
              int.parse('0xFF${channel.hexColor}'),
            ),
            width: AppUIController().borderWidth),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                channel.title,
                textAlign: TextAlign.left,
                style: AppTextStyle.smallBoldBlack.copyWith(
                  letterSpacing: letterSpace ?? 1.5.sp,
                ),
              ),
              const Spacer(),
              // member count
              Text("${channel.membersCount}"),

              const Icon(
                Iconsax.user,
                size: 18,
              )
            ],
          ),
          Text(
            channel.description.length > 50
                ? '${channel.description.substring(0, 50)}'
                    '..'
                : channel.description,
            style: AppTextStyle.smallBlack,
          )
        ],
      ),
    );
  }
}
