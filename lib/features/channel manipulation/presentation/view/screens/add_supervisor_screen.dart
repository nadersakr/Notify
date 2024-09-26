import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/helper/snackbar.dart';
import 'package:notify/features/channel%20manipulation/domin/usecases/add_supervisor.dart';
import 'package:notify/features/channel%20manipulation/presentation/bloc/channel_bloc.dart';
import 'package:notify/features/search/presentation/view/search_screen.dart';
import 'package:notify/shared/domin/entities/loaded_user.dart';
import 'package:notify/shared/domin/entities/user_model.dart';

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
    return BlocProvider(
      create: (context) => sl<ChannelBloc>(),
      child: BlocConsumer<ChannelBloc, ChannelState>(
        listener: (context, state) {
          if (state is AddSupervisorSuccess) {
            ShowSnackBar.successSnackBar(
                context, 'Supervisor added successfully');
          } else if (state is AddSupervisorFailed) {
            ShowSnackBar.errorSnackBar(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          return Scaffold(
              body: SearchScreen(
            isChannelSearch: false,
            onPressed: (object) {
              final user = object as UserModel;

              // Add the selected user as a supervisor
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: const Text('Add Supervisor'),
                    content: Text(
                        'Are you sure you want to add ${user.fullName} as a supervisor?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<ChannelBloc>(context).add(
                            AddSupervisorChannelEvent(
                              params: AddSupervisorParams(
                                channelId: channelId,
                                supervisorId: user.id,
                              ),
                            ),
                          );
                          Navigator.pop(dialogContext);
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
          ));
        },
      ),
    );
  }
}
