import 'package:flutter/material.dart';
import 'package:notify/core/style/app_text_style.dart';

class TextLineUpoveChannels extends StatelessWidget {
  const TextLineUpoveChannels({
    super.key,
    required this.headLineText,
    required this.actionWidget,
  });
  final Widget actionWidget;
  final String headLineText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Text(
            headLineText,
            style: AppTextStyle.largeBlack,
            textAlign: TextAlign.left,
          ),
        ),

        // see all text button
        actionWidget,
      ],
    );
  }
}
