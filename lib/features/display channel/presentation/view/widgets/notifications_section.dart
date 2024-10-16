import 'package:flutter/material.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/features/display%20channel/presentation/view/widgets/channel_notifaction_item.dart';
import 'package:notify/shared/domin/models/notification_model.dart';
import 'package:notify/shared/presentaion/widget/head_line_upove_channels.dart';
import 'package:notify/shared/domin/models/channel_model.dart';
import 'package:notify/shared/presentaion/controller.dart';
import 'package:notify/shared/presentaion/widget/border_container.dart';

Widget buildNotificationsSection(List<NotificationModel> notifications, Channel channel) {
    return Column(
      children: [
        TextLineUpoveChannels(
          headLineText: "Notifications",
          actionWidget: notifications.length > 3
              ? TextButton(
                  onPressed: () {},
                  child: Text("View All", style: AppTextStyle.mediumBlack),
                )
              : SizedBox(height: 2.5 * AppUIController().smallPaddingSpace),
        ),
        BorderContainer(
          color: Color(int.parse('0xff${channel.hexColor}')),
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(10),
            child:notifications.isNotEmpty? Column(
              children: List.generate(
                notifications.length > 3
                    ? 3
                    : notifications.length,
                (index) {
                  
                  return buildNotificationItem(notifications[index], index, channel);
                },
              ),
            ):Center(child: Text("No Notifications",style: AppTextStyle.mediumBlack,))
          ),
        ),
      ],
    );
  }