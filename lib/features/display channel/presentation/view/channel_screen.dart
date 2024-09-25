import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/helper/snackbar.dart';
import 'package:notify/core/routers/app_routers_enum.dart';
import 'package:notify/core/routers/naigator_function.dart';
import 'package:notify/features/channel%20manipulation/presentation/bloc/channel_bloc.dart';
import 'package:notify/features/display%20channel/domin/usecases/load_channel_data.dart';
import 'package:notify/features/display%20channel/presentation/bloc/display_channel_bloc.dart';
import 'package:notify/features/display%20channel/presentation/view/widgets/channel_description_widget.dart';
import 'package:notify/features/display%20channel/presentation/view/widgets/channel_header_widget.dart';
import 'package:notify/features/display%20channel/presentation/view/widgets/channel_image_widget.dart';
import 'package:notify/features/display%20channel/presentation/view/widgets/channel_notification_section.dart';
import 'package:notify/features/display%20channel/presentation/view/widgets/channel_users_seaction.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/domin/entities/fake_channels_for_test.dart';
import 'package:notify/shared/domin/entities/loaded_user.dart';
import 'package:notify/shared/domin/entities/user_model.dart';
import 'package:notify/shared/presentaion/controller.dart';
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
    List<UserModel> supervisors = fakeMembers;

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
            members = state.members;
            supervisors = state.supervisors;
          }
          if (state is DisplayChannelLoading) {
            loading = true;
          }
        },
        builder: (context, state) {
          return BlocListener<ChannelBloc, ChannelState>(
            listener: (context, state) {
              if (state is ChannelManipulationFailed) {
                ShowSnackBar.errorSnackBar(context, state.errorMessage);
              }
              if (state is ChannelManipulationSucess) {
                // Navigator.of(context).pushNamedAndRemoveUntil('/nav_menu',(r)=>false);
                navigateTo(context, AppRouteEnum.navMenu.name);
                ShowSnackBar.successSnackBar(
                  context,
                  state.message,
                );
              }
            },
            child: SafeArea(
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
                            buildChannelHeader(
                                context, channel, isOwner, isJoined),
                            buildChannelImage(channel),
                            buildChannelDescription(channel),
                            buildMembersSection(
                                supervisors, context, "Supervisors",
                                color: Color(
                                    int.parse('0xff${channel.hexColor}'))),
                            buildNotificationsSection(channel),
                            buildMembersSection(members, context, "Members",
                                color: Color(
                                    int.parse('0xff${channel.hexColor}'))),
                          ],
                        ),
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
