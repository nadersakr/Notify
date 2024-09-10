import 'package:flutter/material.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/features/auth/data/data_source/local/local_data_sourece.dart';
import 'package:notify/shared/domin/entities/loaded_user.dart';
import 'package:notify/shared/domin/entities/user_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = LoadedUserData().loadedUser!;
    print(sl<AuthLocalDataSource>().getUser().fullName);
    debugPrint(user.fullName);
    return const Scaffold(
      body: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
