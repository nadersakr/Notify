import 'package:flutter/material.dart';
import 'package:notify/features/auth/presentation/view/login/login_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
 

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: LoginBody(),
    ));
  }
}
