import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notify/core/helper/snackbar.dart';
import 'package:notify/core/style/app_colors.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/core/utils/constant/app_strings.dart';
import 'package:notify/features/home%20screen/presentation/controllers/home_screen_controller.dart';
import 'package:notify/features/home%20screen/presentation/view/widgets/channels_box_vertical.dart';
import 'package:notify/features/nav%20menu/presentation/bloc/app_bloc.dart';
import 'package:notify/shared/presentaion/widget/head_line_upove_channels.dart';
import 'package:notify/shared/presentaion/widget/your_channel_box.dart';
import 'package:notify/shared/domin/models/loaded_user.dart';
import 'package:notify/shared/domin/models/user_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeScreenController controller = HomeScreenController();
    UserModel user = LoadedUserData().loadedUser!;
    debugPrint(user.fullName);
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AppFailed) {
          ShowSnackBar.errorSnackBar(context, "Failed to load data ${state.errorMessage}");
        }
      },
      builder: (context, state) {
        return BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
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
                          Skeletonizer(
                            enabled: state is AppLoading||state is AppFailed,
                            child: ContainerHorizentalBoxWIthBorder(
                              
                                height: controller.yourChannelContainerHeight,
                                channelList: LoadedUserData.userownedChannels,
                                letterSpace: controller.letterSpace),
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
                              onPressed: () {
                                controller.navigateToSearchScreen(context);
                              },
                            ),
                          ),
                          Skeletonizer(
                            enabled: state is AppLoading||state is AppFailed,
                            child: ContainerChannelVertical(
                              maximumNumberOfChannels: 9,
                                channelList: LoadedUserData.biggestChannels,
                                height: controller.yourChannelContainerHeight,
                                letterSpace: controller.letterSpace,
                                onTap: (channel) {
                                  controller.navigateToChannelScreen(
                                      context, channel);
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
