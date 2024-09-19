import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:notify/shared/presentation/controller.dart';

class HomeScreenController extends AppUIController with Sizes, Strings {
  navigateToSearchScreen(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, "/search",(router)=>false);
  }
  void logOut(BuildContext context) {
    sl<AuthBloc>().add(LogoutEvent());
    Navigator.pushReplacementNamed(context, "/login");
  }
}

mixin Sizes {
  double get letterSpace => 1.0;
  double get yourChannelContainerHeight => 60.h;
  // double get bigestchannelContainerHeight => 360.h;
}

mixin Strings {
  String get yourChannelHeadLine => "Your Channels";
  String get seeAllString => "See All";
}
