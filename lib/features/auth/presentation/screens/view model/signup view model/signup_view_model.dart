import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notify/core/routers/app_routers_enum.dart';
import 'package:notify/core/utils/validators/base_validator.dart';
import 'package:notify/core/utils/validators/longer_than_2_chars.dart';
import 'package:notify/core/utils/validators/no_space_validator.dart';
import 'package:notify/core/utils/validators/required_validator.dart';
import 'package:notify/features/auth/presentation/screens/view model/auth_view_model.dart';

class SignupViewModle extends AuthViewModel with Icons, Strings, Sizes, Validators {
  @override
  String get stringGoTo => "Login";

  @override
  Function(BuildContext context) get navigatotGoTO => (BuildContext context) {
        Navigator.pushReplacementNamed(
          context,
          AppRouteEnum.loginPage.name,
        );
      };

  @override
  String get donothaveAccountString => "Already have an account?";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  void signUpWithEmail() {
    if (formKey.currentState!.validate()) {
      print("email : ${emailController.text.toLowerCase().trim()}");
      print("password : ${passwordController.text}");
    }
  }
}

mixin Icons {
  IconData usernameIcon = Iconsax.user_search;
  IconData firstNameIcon = Iconsax.user;
  IconData lastNameIcon = Iconsax.user;
}

mixin Strings {
  String signupString = "Signup";
  String firstNameLabel = "First Name";

  String lastNameLabel = "Last Name";
  String usernameString = "Enter your username";
  String usernameLabel = "username";
}

mixin Validators {
  String? nameValidator(String? value, BuildContext context) =>
      BaseValidator.validateValue(
        context,
        value ?? "",
        [RequiredValidator(), LognerThan2Chars(), NoSpaceValidator()],
        true,
      );

  String? usernameValidator(String? value, BuildContext context) =>
      BaseValidator.validateValue(
        context,
        value ?? "",
        [RequiredValidator(), LognerThan2Chars()],
        true,
      );
}
