import 'package:flutter/material.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:notify/shared/domin/entities/user_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // UserModel user = sl<AuthBloc>().user!;
    return const Scaffold(
      body: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
