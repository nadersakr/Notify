import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/features/home%20screen/presentation/view/widgets/head_line_upove_channels.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/domin/entities/notification_model.dart';
import 'package:notify/shared/domin/entities/user_model.dart';
import 'package:notify/shared/presentation/controller.dart';
import 'package:notify/shared/presentation/widgets/border_container.dart';

class ChannelScreen extends StatelessWidget {
  const ChannelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppUIController appUIController = AppUIController();
    Channel channel = Channel(
      membersCount: 10,
      membersId: ['u1', 'u2', 'u3'],
      superVisorsId: ['d1, d2'],
      creatorId: 'd1',
      id: '1',
      title: 'Flutter Dev Community',
      describtion:
          'A place for Flutter developers to share knowledge and resources.',
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/notify-afb86.appspot.com/o/uploads%2Fcompressed_1726716621961.jpg?alt=media&token=04dd8042-369f-4719-8598-fccbde8d466a',
      hexColor: '42a5f5',
      notifications: [
        NotificationModel(
            id: 'n1',
            message: 'New tutorial on state management available!',
            timestamp: DateTime.now().subtract(const Duration(minutes: 10))),
        NotificationModel(
            id: 'n2',
            message: 'Join our upcoming Flutter meetup!',
            timestamp: DateTime.now().subtract(const Duration(hours: 1))),
        NotificationModel(
            id: 'n3',
            message: 'Weekly coding challenge starts now!',
            timestamp: DateTime.now().subtract(const Duration(days: 1))),
        NotificationModel(
            id: 'n1',
            message: 'New tutorial on state management available!',
            timestamp: DateTime.now().subtract(const Duration(minutes: 10))),
        NotificationModel(
            id: 'n2',
            message: 'Join our upcoming Flutter meetup!',
            timestamp: DateTime.now().subtract(const Duration(hours: 1))),
        NotificationModel(
            id: 'n3',
            message: 'Weekly coding challenge starts now!',
            timestamp: DateTime.now().subtract(const Duration(days: 1))),
      ],
    );

    List<UserModel> members = [
      UserModel(
          id: 'u1',
          fullName: 'Alice Johnson',
          email: 'alice@example.com',
          imageUrl: 'https://via.placeholder.com/150'),
      UserModel(
          id: 'u2',
          fullName: 'Bob Smith',
          email: 'bob@example.com',
          imageUrl: 'https://via.placeholder.com/150'),
      UserModel(
          id: 'u1',
          fullName: 'Alice Johnson',
          email: 'alice@example.com',
          imageUrl: 'https://via.placeholder.com/150'),
      UserModel(
          id: 'u2',
          fullName: 'Bob Smith',
          email: 'bob@example.com',
          imageUrl: 'https://via.placeholder.com/150'),
    ];

    return SafeArea(
      child: Scaffold(
        body: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: appUIController.widgetsWidth,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: appUIController.smallPaddingSpace),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 0.75.sw,
                        child: Text(
                          channel.title,
                          style: AppTextStyle.xLargeBlack
                              .copyWith(letterSpacing: 1.0.sp),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            showMenu(
                              context: context,
                              position:
                                  const RelativeRect.fromLTRB(100, 100, 0, 0),
                              items: [
                                const PopupMenuItem(
                                  value: '4',
                                  child: Row(
                                    children: [
                                      Icon(Iconsax.add_circle),
                                      SizedBox(width: 10),
                                      Text('Add Supervisor'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: '1',
                                  child: Row(
                                    children: [
                                      Icon(Iconsax.edit),
                                      SizedBox(width: 10),
                                      Text('Edit'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: '3',
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
                                  value: '2',
                                  child: Row(
                                    children: [
                                      Icon(Iconsax.close_circle),
                                      SizedBox(width: 10),
                                      Text('Close The Channel'),
                                    ],
                                  ),
                                ),
                              ],
                            ).then((value) {
                              if (value != null) {
                                // Handle menu selection
                                print('Selected: $value');
                              }
                            });
                          },
                          icon: const Icon(Iconsax.candle)),
                    ],
                  ),
                  SizedBox(height: 0.5 * appUIController.smallPaddingSpace),

                  Container(
                    height: 150.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border.all(
                          width: appUIController.borderWidth,
                          color: Color(int.parse('0xff${channel.hexColor}'))),
                      borderRadius: AppUIController().toFitborderRadius,
                    ),
                    child: ClipRRect(
                        borderRadius: AppUIController().borderRadius,
                        child: Stack(
                          children: [
                            Image.network(
                              channel.imageUrl!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ],
                        )),
                  ),
                  SizedBox(height: appUIController.smallPaddingSpace),

                  Text(
                    channel.describtion,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 0.5 * appUIController.smallPaddingSpace),

                  TextLineUpoveChannels(
                    headLineText: "SuperVisors",
                    actionWidget: members.length > 3
                        ? TextButton(
                            onPressed: () {},
                            child: Text("View All",
                                style: AppTextStyle.mediumBlack))
                        : SizedBox(
                            width: 1,
                            height: 2.5 * appUIController.smallPaddingSpace),
                  ),
                  // Members List
                  BorderContainer(
                    color: Color(int.parse('0xff${channel.hexColor}')),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(members.length, (index) {
                          final member = members[index];
                          return Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, bottom: 10),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(member.imageUrl!),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  member.fullName,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  SizedBox(height: 0.5 * appUIController.smallPaddingSpace),

                  TextLineUpoveChannels(
                    headLineText: "Notifications",
                    actionWidget: channel.notifications.length > 3
                        ? TextButton(
                            onPressed: () {},
                            child: Text("View All",
                                style: AppTextStyle.mediumBlack))
                        : SizedBox(
                            width: 1,
                            height: 2.5 * appUIController.smallPaddingSpace),
                  ),
                  BorderContainer(
                      color: Color(int.parse('0xff${channel.hexColor}')),
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: List.generate(
                              channel.notifications.length > 3
                                  ? 3
                                  : channel.notifications.length, (index) {
                            final notification = channel.notifications[index];
                            return SizedBox(
                              // color: Colors.amber,
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notification.message,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    notification.timestamp.toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  if (index != 3 - 1)
                                    Divider(
                                      thickness: 1,
                                      color: Color(
                                          int.parse('0xff${channel.hexColor}')),
                                    ),
                                ],
                              ),
                            );
                          }),
                        ),
                      )),
                  TextLineUpoveChannels(
                    headLineText: "Members",
                    actionWidget: members.length > 3
                        ? TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/view_all_screen',
                                  arguments: members);
                            },
                            child: Text("View All",
                                style: AppTextStyle.mediumBlack))
                        : SizedBox(
                            width: 1,
                            height: 2.5 * appUIController.smallPaddingSpace),
                  ),
                  BorderContainer(
                    color: Color(int.parse('0xff${channel.hexColor}')),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(members.length, (index) {
                          final member = members[index];
                          return Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, bottom: 10),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(member.imageUrl!),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  member.fullName,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  SizedBox(height: appUIController.smallPaddingSpace),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

