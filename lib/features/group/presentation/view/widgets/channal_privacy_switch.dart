import 'package:flutter/material.dart';
import 'package:notify/core/style/app_colors.dart';
import 'package:notify/features/group/presentation/controllers/channal_controller.dart';

class ChannelPrivacySwitch extends StatefulWidget {
  const ChannelPrivacySwitch({super.key});

  @override
  State<ChannelPrivacySwitch> createState() => _ChannelPrivacySwitchState();
}

class _ChannelPrivacySwitchState extends State<ChannelPrivacySwitch> {
  late bool isPrivate;

  @override
  void initState() {
    super.initState();
    isPrivate = ChannalController.isPrivate; // Initialize with the controller value
  }

  @override
  Widget build(BuildContext context) {
    final controller = ChannalController();
    return SwitchListTile(
      contentPadding: const EdgeInsets.all(0),
      activeColor: AppColors.primaryColor,
      inactiveTrackColor: AppColors.primaryColor.withOpacity(0.5),
      inactiveThumbColor: AppColors.white,
      title: const Text('Private Channel'),
      value: isPrivate,
      onChanged: (bool value) {
        setState(() {
          isPrivate = value; // Update the widget's state
          controller.togglePrivacy(value); // Update the controller
        });
      },
    );
  }
}
