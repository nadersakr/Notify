import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notify/core/style/app_text_style.dart';
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
      superVisorsId: ['d1'],
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
          id: 'u3',
          fullName: 'Charlie Brown',
          email: 'charlie@example.com',
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

                  SizedBox(
                    width: 0.75.sw,
                    child: Text(
                      channel.title,
                      style: AppTextStyle.xLargeBlack
                          .copyWith(letterSpacing: 1.0.sp),
                    ),
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
                  SizedBox(height: appUIController.smallPaddingSpace),

                  const Text(
                    'Members:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 0.5 * appUIController.smallPaddingSpace),

                  // Members List
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: members.length,
                      itemBuilder: (context, index) {
                        final member = members[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(member.imageUrl!),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                member.fullName,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: appUIController.smallPaddingSpace),

                  const Text(
                    'Notifications:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 0.5 * appUIController.smallPaddingSpace),
                  //  notification = channel.notifications[index];

                  BorderContainer(
                      color: Color(int.parse('0xff${channel.hexColor}')),
                      child: Column(
                        children: List.generate(channel.notifications.length,
                            (index) {
                          final notification = channel.notifications[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8.0),
                            child: ListTile(
                              title: Text(notification.message),
                              subtitle: Text(
                                notification.timestamp.toLocal().toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          );
                        }),
                      )),
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
