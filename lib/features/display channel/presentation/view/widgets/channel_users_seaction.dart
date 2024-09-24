import 'package:flutter/material.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/features/display%20channel/presentation/view/widgets/channel_member_item.dart';
import 'package:notify/features/home%20screen/presentation/view/widgets/head_line_upove_channels.dart';
import 'package:notify/shared/domin/entities/fake_channels_for_test.dart';
import 'package:notify/shared/domin/entities/user_model.dart';
import 'package:notify/shared/presentaion/controller.dart';
import 'package:notify/shared/presentaion/widget/border_container.dart';

Widget buildMembersSection(
    List<UserModel> members, BuildContext context, String title,
    {Color? color}) {
  return Column(
    children: [
      TextLineUpoveChannels(
        headLineText: title,
        actionWidget: members.length > 3
            ? TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed('/view_all_screen', arguments: members);
                },
                child: Text("View All", style: AppTextStyle.mediumBlack),
              )
            : SizedBox(height: 2.5 * AppUIController().smallPaddingSpace),
      ),
      BorderContainer(
        color: color ?? Color(int.parse('0xff${fakeChannel.hexColor}')),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: members.map((member) => buildMemberItem(member)).toList(),
          ),
        ),
      ),
    ],
  );
}
