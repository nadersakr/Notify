import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notify/core/helper/snackbar.dart';
import 'package:notify/core/routers/app_routers_enum.dart';
import 'package:notify/core/routers/naigator_function.dart';
import 'package:notify/core/style/app_colors.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/features/home%20screen/presentation/view/widgets/channels_box_vertical.dart';
import 'package:notify/features/nav%20menu/presentation/bloc/app_bloc.dart';
import 'package:notify/features/profile/presentation/view/widgets/user_image_widget.dart';
import 'package:notify/shared/domin/models/channel_model.dart';
import 'package:notify/shared/domin/models/loaded_user.dart';
import 'package:notify/shared/presentaion/widget/head_line_upove_channels.dart';
import 'package:notify/shared/domin/models/user_model.dart';
import 'package:notify/shared/presentaion/controller.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    AppUIController appUIController = AppUIController();
    UserModel user = LoadedUserData().loadedUser!;
    // UserModel user = LoadedUserData().loadedUser!;
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AppFailed) {
          ShowSnackBar.errorSnackBar(context, "Failed to load data");
        }
      },
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
                    icon: const Icon(Iconsax.edit),
                    onPressed: () {},
                  )
                ],
              ),
              body: Center(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                        width: appUIController.widgetsWidth,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ImageCircle( imagePath: user.imageUrl),
                              SizedBox(
                                  height:
                                      0.5 * appUIController.smallPaddingSpace),
                              Text(user.fullName,
                                  style: AppTextStyle.xLargeBlack),
                              SizedBox(
                                  height:
                                      0.5 * appUIController.smallPaddingSpace),
                              Text(user.email, style: AppTextStyle.mediumBlack),
                              SizedBox(
                                  height:
                                      0.5 * appUIController.smallPaddingSpace),
                              TextLineUpoveChannels(
                                headLineText: "Joined Channels",
                                actionWidget: TextButton(
                                    onPressed: () {},
                                    child: Text("See All",
                                        style: AppTextStyle.mediumBlack)),
                              ),
                              Skeletonizer(
                                enabled: state is AppLoading,
                                child: ContainerChannelVertical(
                                  maximumNumberOfChannels: 6,
                                  height: 60.h,
                                  channelList: LoadedUserData.joindChannels,
                                  letterSpace: 1.0,
                                  onTap: (Channel channel) {
                                    navigatePushTo(context,
                                        "${AppRouteEnum.channelScreen.name}/${channel.id}");
                                  },
                                ),
                              )
                            ],
                          ),
                        ))),
              ),
            ),
          );
        },
      ),
    );
  }
}


