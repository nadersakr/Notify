import 'package:flutter/material.dart';
import 'package:notify/core/utils/constant/app_strings.dart';
import 'package:notify/shared/domin/models/user_model.dart';

Widget buildMemberItem(UserModel member) {
  return Container(
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
    child: Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[200],
          backgroundImage: NetworkImage(member.imageUrl.isEmpty
              ? AppStrings.personFixedImageUrl
              : member.imageUrl),
        ),
        const SizedBox(height: 4),
        Text(
          member.fullName,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
