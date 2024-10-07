import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notify/core/style/app_text_style.dart';

class RunLottleFile {
  void showNotiftyLottle(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lotties/notify.json', // Your Lottie file path
                    width: 200, // Optional: set width
                    height: 200, // Optional: set height
                    fit: BoxFit.fill, // Optional: fit style
                  ),
                  Text(
                    text,
                    style: AppTextStyle.largeBlack,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
