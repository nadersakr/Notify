import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/helper/snackbar.dart';
import 'package:notify/features/channel/presentation/bloc/channel_bloc.dart';
import 'package:notify/features/channel/presentation/controllers/channel_controller.dart';
import 'package:notify/features/channel/presentation/view/widgets/create_channal_title.dart';
import 'package:notify/features/channel/presentation/view/widgets/channel_description_field.dart';
import 'package:notify/features/channel/presentation/view/widgets/channel_picker_color.dart';
import 'package:notify/features/channel/presentation/view/widgets/channel_privacy_switch.dart';
import 'package:notify/features/channel/presentation/view/widgets/channel_title_field.dart';
import 'package:notify/features/channel/presentation/view/widgets/pick_image_box.dart';
import 'package:notify/features/channel/presentation/view/widgets/create_channel_button.dart';
import 'package:notify/shared/presentation/controller.dart';

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
          return Align(
            alignment: Alignment.center,
            child: SafeArea(
              child: SizedBox(
                width: AppUIController().widgetsWidth,
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppUIController().smallPaddingSpace),
                        const CreateChannelTitle(),
                        SizedBox(height: AppUIController().smallPaddingSpace),
                        const BuildChannalImageUpload(),
                        SizedBox(height: AppUIController().smallPaddingSpace),
                        Form(
                          key: ChannelController.formKey,
                          child: Column(
                            children: [
                              const ChannelTitleField(),
                              SizedBox(
                                  height: AppUIController().smallPaddingSpace),
                              const ChannelDescriptionField(),
                            ],
                          ),
                        ),
                        SizedBox(height: AppUIController().smallPaddingSpace),
                        const ChannelColorPicker(),
                        SizedBox(height: AppUIController().smallPaddingSpace),
                        const ChannelPrivacySwitch(),
                        SizedBox(height: AppUIController().smallPaddingSpace),
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
