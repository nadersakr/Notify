import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notify/core/helper/snackbar.dart';
import 'package:notify/core/routers/naigator_function.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/core/utils/services/copy_a_text_to_the_clipbord.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/delete_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/join_channel.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/leave_channel.dart';
import 'package:notify/features/channel%20manipulation/presentation/bloc/channel_bloc.dart';
import 'package:notify/features/channel%20manipulation/presentation/view/add_supervisor_screen.dart';
import 'package:notify/features/display%20channel/presentation/view/widgets/popup_menu_items.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/domin/entities/loaded_user.dart';

Widget buildChannelHeader(
    BuildContext context, Channel channel, bool isOwner, bool isJoined) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: 0.75.sw,
        child: Text(
          channel.title,
          style: AppTextStyle.xLargeBlack.copyWith(letterSpacing: 1.0.sp),
        ),
      ),
      IconButton(
        onPressed: () {
          showMenu(
            context: context,
            position: const RelativeRect.fromLTRB(100, 100, 0, 0),
            items: isOwner
                ? ownerPopUpMenuItems
                : isJoined
                    ? memberPopUpMenuItems
                    : notMemberPopUpMenuItems,
          ).then((value) {
            switch (value) {
              case "6":
                BlocProvider.of<ChannelBloc>(context).add(DeleteChannelEvent(
                  params: DeleteChannelParams(channel: channel),
                ));
                break;
              case "2":
                // assert(isOwner);
                navigatePushToScreen(
                    context, AddSupervisorScreen(channelId: channel.id));

                break;
              case "4":
                try {
                  copyToClipboard(
                      "http://notifyapp/channel_screen/${channel.id}");

                  ShowSnackBar.successSnackBar(
                      context, "Channel link copied to clipboard");
                } catch (e) {
                  ShowSnackBar.errorSnackBar(context, "Failed to copy link");
                }
                break;
              case "7":
                BlocProvider.of<ChannelBloc>(context).add(JoinChannelEvent(
                  params: JoinChannelParams(
                    channel: channel,
                    joinerId: LoadedUserData().loadedUser!.id,
                  ),
                ));
                break;
              case "5":
                BlocProvider.of<ChannelBloc>(context).add(LeaveChannelEvent(
                  params: LeaveChannelParams(
                    channel: channel,
                    leaverId: LoadedUserData().loadedUser!.id,
                  ),
                ));
                break;
              default:
            }
          });
        },
        icon: const Icon(Iconsax.candle),
      ),
    ],
  );
}
