import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notify/features/auth/presentation/view/login/login_page.dart';
import 'package:notify/features/auth/presentation/view/signup/signup_page.dart';
import 'package:notify/features/display%20channel/presentation/view/channel_screen.dart';
import 'package:notify/features/home%20screen/presentation/view/home_screen.dart';
import 'package:notify/features/nav%20menu/presentation/view/nav_menu.dart';
import 'package:notify/shared/domin/models/loaded_user.dart';

// Define the router
final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',  // Default route
      builder: (context, state) {
        // Redirect based on user authentication status
        if (LoadedUserData().loadedUser == null) {
          return const LoginPage();
        } else {
          return const NavMenu();
        }
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        assert(LoadedUserData().loadedUser != null, "user is required");
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/nav_menu',
      builder: (context, state) {
        assert(LoadedUserData().loadedUser != null, "user is required");
        return const NavMenu();
      },
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) {
        assert(LoadedUserData().loadedUser != null, "user is required");
        return const NavMenu(index: 1);
      },
    ),
    GoRoute(
      path: '/channel_screen/:channelId',
      builder: (context, state) {
        assert(LoadedUserData().loadedUser != null, "user is required");
        final channelId = state.pathParameters['channelId'];
        assert(channelId != null, "channel Id is required");
        return ChannelScreen(channelId: channelId!);
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('No route defined for ${state.path}'),
    ),
  ),
);
