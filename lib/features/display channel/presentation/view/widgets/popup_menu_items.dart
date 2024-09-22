import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

List<PopupMenuItem> popUpMenuItems = [
  const PopupMenuItem(
    value: '1',
    child: Row(
      children: [
        Icon(Iconsax.add_circle),
        SizedBox(width: 10),
        Text('send Notification'),
      ],
    ),
  ),
  const PopupMenuItem(
    value: '2',
    child: Row(
      children: [
        Icon(Iconsax.add_circle),
        SizedBox(width: 10),
        Text('Add Supervisor'),
      ],
    ),
  ),
  const PopupMenuItem(
    value: '3',
    child: Row(
      children: [
        Icon(Iconsax.edit),
        SizedBox(width: 10),
        Text('Edit'),
      ],
    ),
  ),
  const PopupMenuItem(
    value: '4',
    child: Row(
      children: [
        Icon(Iconsax.share),
        SizedBox(width: 10),
        Text('Share'),
      ],
    ),
  ),
  const PopupMenuItem(
    value: '5',
    child: Row(
      children: [
        Icon(Iconsax.arrow_down_2),
        SizedBox(width: 10),
        Text('Leave'),
      ],
    ),
  ),
  const PopupMenuItem(
    value: '6',
    child: Row(
      children: [
        Icon(Iconsax.close_circle),
        SizedBox(width: 10),
        Text('Close The Channel'),
      ],
    ),
  ),
];
