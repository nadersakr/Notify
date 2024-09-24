import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/helper/snackbar.dart';
import 'package:notify/features/channel%20manipulation/presentation/bloc/channel_bloc.dart';
import 'package:notify/features/channel%20manipulation/presentation/controllers/channel_controller.dart';
import 'package:notify/features/channel%20manipulation/presentation/view/widgets/create_channal_title.dart';
import 'package:notify/features/channel%20manipulation/presentation/view/widgets/channel_description_field.dart';
import 'package:notify/features/channel%20manipulation/presentation/view/widgets/channel_picker_color.dart';
import 'package:notify/features/channel%20manipulation/presentation/view/widgets/channel_privacy_switch.dart';
import 'package:notify/features/channel%20manipulation/presentation/view/widgets/channel_title_field.dart';
import 'package:notify/features/channel%20manipulation/presentation/view/widgets/pick_image_box.dart';
import 'package:notify/features/channel%20manipulation/presentation/view/widgets/create_channel_button.dart';
import 'package:notify/shared/presentaion/controller.dart';

class CreateChannelScreen extends StatelessWidget {
  const CreateChannelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ChannelBloc>(),
      child: BlocConsumer<ChannelBloc, ChannelState>(
        listener: (context, state) {
          if (state is CreateChannelLoading) {}
          if (state is CreateChannelFailed) {
            ShowSnackBar.errorSnackBar(context, state.errorMessage);
          }
          if (state is CreateChannelSuccess) {
            ChannelController.resetParamters();
            Navigator.pushNamedAndRemoveUntil(
                context, "/nav_menu", (router) => false);
            ShowSnackBar.successSnackBar(
                context, "Channel created Successfully");
          }
        },
        builder: (context, state) {
          final AppUIController appUIController = AppUIController();
          return Align(
            alignment: Alignment.center,
            child: SafeArea(
              child: SizedBox(
                width: appUIController.widgetsWidth,
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: appUIController.smallPaddingSpace),
                        const CreateChannelTitle(),
                        SizedBox(height: appUIController.smallPaddingSpace),
                        const BuildChannalImageUpload(),
                        SizedBox(height: appUIController.smallPaddingSpace),
                        Form(
                          key: ChannelController.formKey,
                          child: Column(
                            children: [
                              const ChannelTitleField(),
                              SizedBox(
                                  height: appUIController.smallPaddingSpace),
                              const ChannelDescriptionField(),
                            ],
                          ),
                        ),
                        SizedBox(height: appUIController.smallPaddingSpace),
                        const ChannelColorPicker(),
                        SizedBox(height: appUIController.smallPaddingSpace),
                        const ChannelPrivacySwitch(),
                        SizedBox(height: appUIController.smallPaddingSpace),
                        const CreateChannelButton(),
                        
                      ],
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
