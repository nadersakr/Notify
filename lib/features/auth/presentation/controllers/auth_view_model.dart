import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notify/core/utils/validators/base_validator.dart';
import 'package:notify/core/utils/validators/email_validator.dart';
import 'package:notify/core/utils/validators/longer_than_chars.dart';
import 'package:notify/core/utils/validators/required_validator.dart';
import 'package:notify/shared/presentaion/controller.dart';

abstract class AuthViewModel extends AppUIController
    with Icons, Strings, Sizes, Validators {
  String get stringGoTo;
  String get donothaveAccountString;
  Function(BuildContext context) get navigatotGoTO;

  void showPassword(bool isConfirmePassword) {
    if (isConfirmePassword) {
      isConfirmedPasswordVisible = !isConfirmedPasswordVisible;
      // print("showing Password is $isConfirmedPasswordVisible");
      if (isConfirmedPasswordVisible) {
        passwordIcon = Iconsax.lock;
      } else {
        passwordIcon = Iconsax.unlock;
      }
    } else {
      isPasswordVisible = !isPasswordVisible;
      // print("showing Password is $isPasswordVisible");
      if (isPasswordVisible) {
        passwordIcon = Iconsax.lock;
      } else {
        passwordIcon = Iconsax.unlock;
      }
    }
  }
}

mixin Icons {
  IconData emailIcon = Iconsax.user;
  IconData passwordIcon = Iconsax.lock;
}

mixin Sizes {
  double imageSize = 160.h;
  double googleIconSize = 30.h;
  double smallpaddingSpace = 10.h;
  double largepaddingSpace = 90.h;
  double signinWithGoogleHeight = 50.h;
  double borderWidth = 1.5.w;
  double letterSpace = 1.5.w;
}

mixin Strings {
  String emailString = "Enter your email";
  String passwordString = "Enter your password";
  String confirmPasswordString = "Re-enter your password";
  String emailLabel = "Email";
  String passwordLabel = "Password";
  String confirmPasswordLable = "Confirm Password";
  String signinWithGoogleString = "Sign in with Google";
  String notifyString = "Notify";
  String headLine =
      'You can push your notification for others and get notified';
  bool isPasswordVisible = true;
  bool isConfirmedPasswordVisible = true;
  String googleIcon = "assets/google_icon.png";
}
mixin Validators {
// email validator
  String? emailValidator(String? value, BuildContext context) =>
      BaseValidator.validateValue(
        context,
        value ?? "",
        [RequiredValidator(), ValiedEmail()],
        true,
      );
  String? passwordValidator(String? value, BuildContext context) =>
      BaseValidator.validateValue(
        context,
        value ?? "",
        [RequiredValidator(), LognerThanChars(7)],
        true,
      );
}
