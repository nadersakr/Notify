import 'package:flutter/material.dart';
import 'package:notify/shared/domin/entities/loaded_user.dart';
import 'package:notify/shared/domin/entities/user_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user =LoadedUserData().loadedUser! ;
    debugPrint(user.fullName);
    return const Scaffold(
      body: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
