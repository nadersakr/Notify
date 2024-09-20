import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notify/core/style/app_colors.dart';

class ShowSnackBar {
  static errorSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(Iconsax.warning_2, color: AppColors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.errorColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sp),
      ),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Undo',
        textColor: AppColors.white,
        onPressed: () {
          // Some code to undo the change.
        },
      ),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static warningSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(Iconsax.warning_2, color: AppColors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.warrningColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sp),
      ),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Undo',
        textColor: AppColors.white,
        onPressed: () {
          // Some code to undo the change.
        },
      ),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static successSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(Iconsax.tick_circle, color: AppColors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.successColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sp),
      ),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Undo',
        textColor: AppColors.white,
        onPressed: () {
          // Some code to undo the change.
        },
      ),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
