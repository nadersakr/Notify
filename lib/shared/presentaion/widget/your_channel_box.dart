import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notify/core/style/app_colors.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/shared/domin/models/channel_model.dart';

class ContainerHorizentalBoxWIthBorder extends StatelessWidget {
  const ContainerHorizentalBoxWIthBorder({
    super.key,
    required this.height,
    required this.letterSpace,
    required this.channelList,
    required this.onTap,
  });
  final double height;
  final double letterSpace;
  final List<Channel> channelList;
  final void Function(Channel channel) onTap;

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

                return GestureDetector(
                  onTap: ()=> onTap(channel),
                  child: Container(
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
                    child: Center(
                      child: Text(
                        channel.title,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.smallBoldBlack.copyWith(
                          letterSpacing: letterSpace,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : const Center(child: Text("You aren't supervisor for any Channel!")),
    );
  }
}
