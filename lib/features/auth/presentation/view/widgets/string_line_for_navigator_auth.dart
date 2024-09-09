import 'package:flutter/material.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/features/auth/presentation/controllers/auth_view_model.dart';

class StringLineForSwituchAuth extends StatelessWidget {
  const StringLineForSwituchAuth({
    super.key,
    required this.controller,
  });

  final AuthViewModel controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(controller.donothaveAccountString,
            style: AppTextStyle.mediumBlack),
        TextButton(
            onPressed: () {
              controller.navigatotGoTO(context);
            },
            child: Text(
              controller.stringGoTo,
              style: AppTextStyle.mediumOrangeBold,
            ))
      ],
    );
  }
}