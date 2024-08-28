import 'package:flutter/material.dart';
import 'package:notify/core/routers/app_routers_enum.dart';
import 'package:notify/features/auth/presentation/screens/view model/auth_view_model.dart';

class LoginViewModle extends AuthViewModel
    with AssetsStrings, Strings, Sizes {
  @override
  Function(BuildContext context) get navigatotGoTO => (BuildContext context) {
        Navigator.pushReplacementNamed(
          context,
          AppRouteEnum.signUpPage.name,
        );
      };

  @override
  String get stringGoTo => "Sign Up";

  @override
  String get donothaveAccountString => "Don't have an account?";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  void login() {
    if (formKey.currentState!.validate()) {
      print("email : ${emailController.text.toLowerCase().trim()}");
      print("password : ${passwordController.text}");
    }
  }
}

mixin AssetsStrings {
  String notify = "assets/notify.png";
}

mixin Strings {
  String emailString = "Enter your email";
  String passwordString = "Enter your password";
  String emailLabel = "Email";
  String passwordLabel = "Password";
  String loginString = "Login";
  String notifyString = "Notify";
  String headLine =
      'You can push your notification for others and get notified';
}


