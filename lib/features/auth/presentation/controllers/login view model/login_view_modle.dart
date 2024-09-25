import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/routers/app_routers_enum.dart';
import 'package:notify/core/routers/naigator_function.dart';
import 'package:notify/features/auth/domin/usecases/login.dart';
import 'package:notify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:notify/features/auth/presentation/controllers/auth_view_model.dart';

class LoginViewModle extends AuthViewModel with AssetsStrings, Strings, Sizes {
  static get wrongCredential => "email or password is wrong";
  static get weakPassword => "weak password";
  static get defaultError => "Error Occured";
  static get errorInLoadingUserData => "Error in loading user data";

  @override
  Function(BuildContext context) get navigatotGoTO => (BuildContext context) {
        // Navigator.pushReplacementNamed(
        //   context,
        //   AppRouteEnum.signUpPage.name,
        // );
        navigateTo(context, AppRouteEnum.signUpPage.name);
      };

  @override
  String get stringGoTo => "Sign Up";

  @override
  String get donothaveAccountString => "Don't have an account?";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  void login(BuildContext context) {
    if (formKey.currentState!.validate()) {
      // print("email : ${emailController.text.toLowerCase().trim()}");
      // print("password : ${passwordController.text}");

      final params = LoginParams(
        email: emailController.text.toLowerCase().trim(),
        password: passwordController.text,
      );
      BlocProvider.of<AuthBloc>(context).add(AuthLoginEvent(params: params));
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
