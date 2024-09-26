import 'package:flutter/material.dart';
import 'package:notify/features/search/presentation/view/search_screen.dart';
import 'package:notify/shared/domin/entities/loaded_user.dart';

class AddSupervisorScreen extends StatelessWidget {
  final String channelId;
  const AddSupervisorScreen({
    super.key,
    required this.channelId,
  });

  @override
  Widget build(BuildContext context) {
    // print(LoadedUserData().loadedUser!.ownedChannels);
    // to be sure that the user is a supervisor
    assert(LoadedUserData().loadedUser!.ownedChannels.contains(channelId));
    return const Scaffold(body: SearchScreen());
  }
}
