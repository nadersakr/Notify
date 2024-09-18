import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notify/core/style/app_colors.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/core/utils/constant/app_strings.dart';
import 'package:notify/features/home%20screen/presentation/controllers/home_screen_controller.dart';
import 'package:notify/features/home%20screen/presentation/view/widgets/head_line_upove_channels.dart';
import 'package:notify/shared/domin/entities/fake_channels_for_test.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/domin/entities/loaded_user.dart';
import 'package:notify/shared/domin/entities/user_model.dart';
import 'package:notify/shared/presentaion/widget/channel_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeScreenController controller = HomeScreenController();
    UserModel user = LoadedUserData().loadedUser!;
    debugPrint(user.fullName);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: const Icon(Iconsax.logout),
              onPressed: () {
                controller.logOut(context);
              },
            )
          ],
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: controller.widgetsWidth,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Iconsax.notification4,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        AppStrings.appName,
                        style: AppTextStyle.xxLargeBlack.copyWith(
                          letterSpacing: controller.letterSpace,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: controller.smallPaddingSpace,
                  ),
                  TextLineUpoveChannels(
                    headLineText: controller.yourChannelHeadLine,
                    actionWidget: TextButton(
                        onPressed: () {},
                        child: Text(controller.seeAllString,
                            style: AppTextStyle.mediumBlack)),
                  ),
                  Container(
                    height: controller.yourChannelContainerHeight,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: channelList.length,
                      itemBuilder: (context, index) {
                        Channel channel = channelList[index];

                        final Color color =
                            Color(int.parse('0xFF${channel.hexColor}'));

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
                                  letterSpacing: controller.letterSpace,
                                ),
                              ),
                            ),
                          ]),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: controller.smallPaddingSpace,
                  ),
                  TextLineUpoveChannels(
                    headLineText: "Bigest Channels",
                    actionWidget: IconButton(
                      icon: const Icon(Iconsax.search_normal_1),
                      iconSize: 24.sp,
                      color: AppColors.gray,
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: List.generate(4, (index) {
                        final Channel channel = channelList[index];
                        return ChannelOverviewContainer(
                            height: controller.yourChannelContainerHeight,
                            letterSpace: controller.letterSpace,
                            channel: channel);
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
