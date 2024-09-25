import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/routers/app_routers_enum.dart';
import 'package:notify/core/routers/naigator_function.dart';
import 'package:notify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/presentaion/controller.dart';

class HomeScreenController extends AppUIController with Sizes, Strings {
  navigateToSearchScreen(BuildContext context) {
    // Navigator.pushNamedAndRemoveUntil(context, "/search", (router) => false);
    navigateTo(context, AppRouteEnum.search.name);
  }

  navigateToChannelScreen(BuildContext context, Channel channel) {
    navigatePushTo(context, "${AppRouteEnum.channelScreen.name}/${channel.id}");
    // Navigator.pushNamed(context, "/channel_screen", arguments: channel.id);
  }

  void logOut(BuildContext context) {
    sl<AuthBloc>().add(LogoutEvent());
    navigateTo(context, AppRouteEnum.loginPage.name);
    // Navigator.pushReplacementNamed(context, "/login");
  }
}

mixin Sizes {
  double get letterSpace => 1.0;
  double get yourChannelContainerHeight => 60.h;
  // double get bigestchannelContainerHeight => 360.h;
}

mixin Strings {
  String get yourChannelHeadLine => "Your Channels";
  String get seeAllString => "View All";
}
