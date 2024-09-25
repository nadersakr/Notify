import 'package:flutter/material.dart';
import 'package:notify/shared/domin/entities/loaded_user.dart';

class AddSupervisorScreen extends StatelessWidget {
  final String channelId;
  const AddSupervisorScreen({
    super.key,
    required this.channelId,
  });

  @override
  Widget build(BuildContext context) {
    // to be sure that the user is a supervisor
    assert(LoadedUserData().loadedUser!.channelsId.contains(channelId));
    return Scaffold(
      body: Center(
        child: Text('Add Supervisor Screen $channelId'),
      ),
    );
  }
}
