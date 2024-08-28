import 'package:flutter/material.dart';
import 'package:notify/features/auth/presentation/screens/signup/signup_body.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      // appBar: AppBar(),
      body: SignupBody(),
    ));
  }
}
