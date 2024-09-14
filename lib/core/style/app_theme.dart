import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notify/core/style/app_text_style.dart';

// import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Light theme
final ThemeData appTheme = ThemeData(
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.primaryColor,
    // Change this to your desired color
  ),
  dialogBackgroundColor: AppColors.lightGray,
  cardColor: AppColors.primaryColor,
  appBarTheme: AppBarTheme(
    // shadowColor: AppColors.lightGray,
    color: AppColors.transparent,
    elevation: 0,
    toolbarTextStyle: TextTheme(
      titleLarge: AppTextStyle.xxxLargeBlack,
    ).bodyLarge,
    titleTextStyle: TextTheme(
      titleLarge: AppTextStyle.xxxLargeBlack,
    ).titleLarge,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  fontFamily: "Montserrat",
  scaffoldBackgroundColor: AppColors.white,
  iconTheme: const IconThemeData(color: AppColors.black, size: 25),
  textTheme: TextTheme(
    headlineLarge: AppTextStyle.xxxLargeBlack,
    headlineMedium: AppTextStyle.xLargeBlack,
    titleMedium: AppTextStyle.xSmallBlack,
    titleSmall: AppTextStyle.smallBlack,
    bodyLarge: AppTextStyle.largeBlack,
    bodyMedium: AppTextStyle.mediumBlack,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 12.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sp),
      ),
    ),
  ),
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: AppColors.primaryColor),
  inputDecorationTheme: InputDecorationTheme(
      hintStyle: AppTextStyle.mediumBlack,
      fillColor: AppColors.transparent,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 10.sp,
      ),
      labelStyle: AppTextStyle.mediumBlack,
      suffixIconColor: AppColors.black,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: const BorderSide(color: AppColors.white, width: 1)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: const BorderSide(color: AppColors.white, width: 1)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: const BorderSide(color: AppColors.white, width: 1)),
      errorMaxLines: 2),
);

/// Dark theme
final ThemeData darkAppTheme = ThemeData(
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.primaryColor,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: AppTextStyle.mediumBlack,
    ),
  ),
  dialogBackgroundColor: AppColors.primaryColor,
  cardColor: AppColors.primaryColor.withOpacity(0.5),
  appBarTheme: AppBarTheme(
    shadowColor: AppColors.transparent,
    color: AppColors.transparent,
    elevation: 0,
    toolbarTextStyle: TextTheme(
      titleLarge: AppTextStyle.xxxLargeWhite,
    ).bodyLarge,
    titleTextStyle: TextTheme(
      titleLarge: AppTextStyle.xxxLargeWhite,
    ).titleLarge,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  fontFamily: "Montserrat",
  scaffoldBackgroundColor: AppColors.primaryColor,
  iconTheme: const IconThemeData(color: AppColors.white, size: 25),
  textTheme: TextTheme(
    headlineLarge: AppTextStyle.xxxLargeWhite,
    headlineMedium: AppTextStyle.xLargeWhite,
    titleMedium: AppTextStyle.xSmallWhite,
    titleSmall: AppTextStyle.smallWhite,
    bodyLarge: AppTextStyle.largeWhite,
    bodyMedium: AppTextStyle.mediumWhite,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      padding: EdgeInsets.symmetric(
        horizontal: 50.w,
        vertical: 12.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: AppColors.primaryColor),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(
      horizontal: 10.w,
    ),
    hintStyle: AppTextStyle.mediumWhite,
    labelStyle: AppTextStyle.mediumWhite,
    filled: true,
    suffixIconColor: AppColors.white,
    fillColor: AppColors.transparent,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.sp),
        borderSide: const BorderSide(color: AppColors.lightGray, width: 1)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.sp),
        borderSide: const BorderSide(color: AppColors.lightGray, width: 1)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.sp),
        borderSide: const BorderSide(color: AppColors.lightGray, width: 1)),
    errorMaxLines: 2,
  ),
);
