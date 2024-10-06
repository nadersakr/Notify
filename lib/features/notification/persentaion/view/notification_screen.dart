import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/features/nav%20menu/presentation/bloc/app_bloc.dart';
import 'package:notify/shared/domin/models/loaded_user.dart';
import 'package:notify/shared/presentaion/controller.dart';
import 'package:notify/shared/presentaion/widget/border_container.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NoificationScreen extends StatelessWidget {
  const NoificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppUIController appUIController = AppUIController();
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: appUIController.widgetsWidth,
                child: Column(
                  children: [
                    SizedBox(
                      height: appUIController.smallPaddingSpace,
                    ),
                    BorderContainer(
                        child: Container(
                      margin: const EdgeInsets.all(16),
                      child: Skeletonizer(
                                                        enabled: state is AppLoading,

                        child: LoadedUserData
                                            .notifications.isNotEmpty
                                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                                LoadedUserData.notifications.length,
                                (index) => BorderContainer(
                                  
                                    color: Color(int.parse(
                                        '0xff${LoadedUserData.notifications[index].hexColor}')),
                                    child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                LoadedUserData
                                                        .notifications[index]
                                                        .channelTitle ??
                                                    "Channel Title",
                                                style: AppTextStyle.largeBlack,
                                              ),
                                              Text(LoadedUserData
                                                  .notifications[index]
                                                  .message),
                                            ],
                                          )
                                       ))):  const Text(
                                            "No Notification Found"),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
