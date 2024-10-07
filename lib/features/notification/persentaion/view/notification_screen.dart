import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
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
                          child: LoadedUserData.notifications.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                      LoadedUserData.notifications.length,
                                      (index) => Column(
                                            children: [
                                              BorderContainer(
                                                  color: Color(int.parse(
                                                      '0xff${LoadedUserData.notifications[index].hexColor}')),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8,
                                                                top: 8),
                                                        child: Text(
                                                          LoadedUserData
                                                              .notifications[
                                                                  index]
                                                              .message,
                                                          style: AppTextStyle
                                                              .xLargeBlack,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          LoadedUserData
                                                                  .notifications[
                                                                      index]
                                                                  .channelTitle ??
                                                              "Channel Title",
                                                          style: AppTextStyle
                                                              .mediumBlack,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              if (index !=
                                                  LoadedUserData.notifications
                                                          .length -
                                                      1)
                                                SizedBox(
                                                  height: appUIController
                                                      .smallPaddingSpace,
                                                )
                                            ],
                                          )))
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (state is! AppLoading)
                                      Lottie.asset(
                                        'assets/lotties/no_notifications.json', 
                                        height:
                                            200, 
                                        fit: BoxFit.fill, 
                                      ),
                                    Text(
                                      "You didn't receive any notification",
                                      style: AppTextStyle.mediumBlack,
                                    ),
                                  ],
                                ),
                        ),
                      )),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }
}
