import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/style/app_colors.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:notify/features/auth/presentation/controllers/auth_view_model.dart';
import 'package:notify/shared/presentation/controller.dart';

class SignInWithGoogleWidget extends StatelessWidget {
  const SignInWithGoogleWidget({
    super.key,
    required this.controller,
  });

  final AuthViewModel controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final authBloc = BlocProvider.of<AuthBloc>(context);
        if (authBloc.isClosed) {
          debugPrint("authBloc is closed");
        } else {
          authBloc.add(SignInWithGoogleEvent());
        }
      },
      child: Container(
        height: controller.signinWithGoogleHeight,
        width: controller.widgetsWidth,
        decoration: BoxDecoration(
          borderRadius: AppUIController().textFormFieldborderRadius,
          border:
              Border.all(color: AppColors.black, width: controller.borderWidth),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.signinWithGoogleString,
                style: AppTextStyle.mediumBlack,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: controller.smallpaddingSpace,
              ),
              SizedBox(
                width: controller.googleIconSize,
                height: controller.googleIconSize,
                child: Image.asset(controller.googleIcon),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
