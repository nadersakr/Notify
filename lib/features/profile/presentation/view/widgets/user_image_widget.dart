import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notify/core/style/app_colors.dart';
import 'package:notify/shared/presentaion/controller.dart';

class ImageCircle extends StatelessWidget {
  const ImageCircle({
    super.key,
    this.imagePath,
    this.size,
  });

  final String? imagePath;  // One variable for all image types
  final double? size;

  bool _isNetworkImage(String path) {
    return path.startsWith('http') || path.startsWith('https');
  }

  bool _isFileImage(String path) {
    return File(path).existsSync();
  }

  @override
  Widget build(BuildContext context) {
    AppUIController appUIController = AppUIController();
    return Container(
      width: size ?? 80.h,
      height: size ?? 80.h,
      decoration: BoxDecoration(
        border: Border.all(
            width: appUIController.borderWidth, color: AppColors.primaryColor),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    if (imagePath != null) {
      if (_isNetworkImage(imagePath!)) {
        // Network image
        return Image.network(
          imagePath!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Iconsax.user,
              size: 50,
              color: AppColors.primaryColor,
            );
          },
        );
      } else if (_isFileImage(imagePath!)) {
        // File image
        return Image.file(
          File(imagePath!),
          fit: BoxFit.cover,
        );
      } else {
        // Asset image
        return Image.asset(
          imagePath!,
          fit: BoxFit.cover,
        );
      }
    } else {
      // Default icon if no image is provided
      return const Icon(
        Iconsax.user,
        size: 50,
        color: AppColors.primaryColor,
      );
    }
  }
}
