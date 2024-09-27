import 'package:flutter/material.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';

Widget buildChannelDescription(Channel channel) {
  return Text(
    channel.description,
    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
  );
}
