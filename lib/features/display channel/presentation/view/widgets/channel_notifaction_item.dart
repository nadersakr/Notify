import 'package:flutter/material.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/domin/entities/notification_model.dart';

Widget buildNotificationItem(
      NotificationModel notification, int index, Channel channel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          notification.message,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          notification.timestamp.toString(),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        if (index != 2) // Assuming you limit to 3 items
          Divider(
            thickness: 1,
            color: Color(int.parse('0xff${channel.hexColor}')),
          ),
      ],
    );
  }