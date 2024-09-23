import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/presentation/controller.dart';

Widget buildChannelImage(Channel channel) {
    return Container(
      height: 150.h,
      decoration: BoxDecoration(
        border: Border.all(
          width: AppUIController().borderWidth,
          color: Color(int.parse('0xff${channel.hexColor}')),
        ),
        borderRadius: AppUIController().toFitborderRadius,
      ),
      child: ClipRRect(
        borderRadius: AppUIController().borderRadius,
        child: Image.network(
          channel.imageUrl!,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }