import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notify/core/style/app_colors.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';

class ContainerHorizentalBoxWIthBorder extends StatelessWidget {
  const ContainerHorizentalBoxWIthBorder({
    super.key,
    required this.height,
    required this.letterSpace,
    required this.channelList,
  });
  final double height;
  final double letterSpace;
  final List<Channel> channelList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primaryColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: channelList.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: channelList.length,
              itemBuilder: (context, index) {
                Channel channel = channelList[index];

                final Color color = Color(int.parse('0xFF${channel.hexColor}'));

                return Container(
                  width: 100.w,
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: color,
                    ),
                    // color: color.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(children: [
                    // blur
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(),
                      ),
                    ),
                    Center(
                      child: Text(
                        channel.title,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.smallBoldBlack.copyWith(
                          letterSpacing: letterSpace,
                        ),
                      ),
                    ),
                  ]),
                );
              },
            )
          : const Center(child: Text("You didn't join to any Channel!")),
    );
  }
}
