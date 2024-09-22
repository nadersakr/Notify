import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/send_notification.dart';
import 'package:notify/features/channel%20manipulation/presentation/bloc/channel_bloc.dart';
import 'package:notify/features/display%20channel/domin/usecases/load_channel_data.dart';
import 'package:notify/features/display%20channel/presentation/bloc/display_channel_bloc.dart';
import 'package:notify/features/display%20channel/presentation/view/widgets/popup_menu_items.dart';
import 'package:notify/features/home%20screen/presentation/view/widgets/head_line_upove_channels.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/domin/entities/fake_channels_for_test.dart';
import 'package:notify/shared/domin/entities/loaded_user.dart';
import 'package:notify/shared/domin/entities/notification_model.dart';
import 'package:notify/shared/domin/entities/user_model.dart';
import 'package:notify/shared/presentation/controller.dart';
import 'package:notify/shared/presentation/widgets/border_container.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ChannelScreen extends StatelessWidget {
  final String channelId;
  const ChannelScreen({super.key, required this.channelId});

  @override
  Widget build(BuildContext context) {
    bool isOwner = false;
    bool isJoined = false;
    Channel channel = fakeChannel;
    final AppUIController appUIController = AppUIController();
    bool loading = false;

    List<UserModel> members = fakeMembers;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<DisplayChannelBloc>()
            ..add(GetChannelDataEvent(
                LoadChannelDataParams(channelId: channelId))),
        ),
        BlocProvider(
          create: (context) => sl<ChannelBloc>(),
        ),
      ],
      child: BlocConsumer<DisplayChannelBloc, DisplayChannelState>(
        listener: (context, state) {
          if (state is DisplayChannelFailed) {
            loading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
          if (state is DisplayChannelLoaded) {
            loading = false;
            channel = state.channel;
            isOwner = state.channel.supervisorsId
                .contains(LoadedUserData().loadedUser!.id);

            isJoined = state.channel.membersId
                .contains(LoadedUserData().loadedUser!.id);
            print("isOwner $isOwner");
            print("isJoined $isJoined");
          }
          if (state is DisplayChannelLoading) {
            loading = true;
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: appUIController.widgetsWidth,
                  child: Skeletonizer(
                    enabled: loading,
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
                                    position: const RelativeRect.fromLTRB(
                                        100, 100, 0, 0),
                                    items: isOwner
                                        ? ownerPopUpMenuItems
                                        : isJoined
                                            ? memberPopUpMenuItems
                                            : notMemberPopUpMenuItems,
                                  ).then((value) {
                                    if (value != null) {
                                      debugPrint('Selected: $value');
                                    }
                                  });
                                },
                                icon: const Icon(Iconsax.candle),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: 0.5 * appUIController.smallPaddingSpace),

                          Container(
                            height: 150.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: appUIController.borderWidth,
                                  color: Color(
                                      int.parse('0xff${channel.hexColor}'))),
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
                            channel.description,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                              height: 0.5 * appUIController.smallPaddingSpace),

                          TextLineUpoveChannels(
                            headLineText: "Supervisors",
                            actionWidget: members.length > 3
                                ? TextButton(
                                    onPressed: () {},
                                    child: Text("View All",
                                        style: AppTextStyle.mediumBlack))
                                : SizedBox(
                                    width: 1,
                                    height: 2.5 *
                                        appUIController.smallPaddingSpace),
                          ),
                          // Members List
                          BorderContainer(
                            color: Color(int.parse('0xff${channel.hexColor}')),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children:
                                    List.generate(members.length, (index) {
                                  final member = members[index];
                                  return Container(
                                    margin: const EdgeInsets.all(5),
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10, bottom: 10),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.grey[200],
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
                          SizedBox(
                              height: 0.5 * appUIController.smallPaddingSpace),

                          TextLineUpoveChannels(
                            headLineText: "Notifications",
                            actionWidget: channel.notifications.length > 3
                                ? TextButton(
                                    onPressed: () {},
                                    child: Text("View All",
                                        style: AppTextStyle.mediumBlack))
                                : SizedBox(
                                    width: 1,
                                    height: 2.5 *
                                        appUIController.smallPaddingSpace),
                          ),
                          BorderContainer(
                              color:
                                  Color(int.parse('0xff${channel.hexColor}')),
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: List.generate(
                                      channel.notifications.length > 3
                                          ? 3
                                          : channel.notifications.length,
                                      (index) {
                                    final notification =
                                        channel.notifications[index];
                                    return SizedBox(
                                      // color: Colors.amber,
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              color: Color(int.parse(
                                                  '0xff${channel.hexColor}')),
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
                                      Navigator.of(context).pushNamed(
                                          '/view_all_screen',
                                          arguments: members);
                                    },
                                    child: Text("View All",
                                        style: AppTextStyle.mediumBlack))
                                : SizedBox(
                                    width: 1,
                                    height: 2.5 *
                                        appUIController.smallPaddingSpace),
                          ),
                          BorderContainer(
                            color: Color(int.parse('0xff${channel.hexColor}')),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children:
                                    List.generate(members.length, (index) {
                                  final member = members[index];
                                  return Container(
                                    margin: const EdgeInsets.all(5),
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10, bottom: 10),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.white,
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
            ),
          );
        },
      ),
    );
  }
}
