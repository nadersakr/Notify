import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notify/features/auth/presentation/view/login/login_page.dart';
import 'package:notify/features/auth/presentation/view/signup/signup_page.dart';
import 'package:notify/features/home%20screen/presentation/view/home_screen.dart';
import 'package:notify/shared/domin/entities/loaded_user.dart';

class AppRouter {
  static String currentRoute = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    currentRoute = settings.name ?? "/";
    switch (settings.name) {
      // login page
      case '/login':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const LoginPage(),
        );

      // sign up page
      case '/signup':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) {
            return const SignupPage();
          },
        );
      case '/home':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) {
            assert(LoadedUserData().loadedUser != null,"user is required");
            // assert(
                // settings.arguments != null, "signup is required");
            return const HomeScreen();
          },
        );

      // // Web view page
      // case '/web_view_page':
      //   return CupertinoPageRoute(
      //     settings: RouteSettings(name: settings.name),
      //     builder: (_) => WebViewPage(
      //       link: settings.arguments as String,
      //     ),
      //   );

      // // Photo view page
      // case '/photo_view_page':
      //   return CupertinoPageRoute(
      //     settings: RouteSettings(name: settings.name),
      //     builder: (_) {
      //       Map<String, dynamic>? args =
      //           settings.arguments as Map<String, dynamic>?;
      //       assert(args != null, "You should pass 'path' and 'fromNet'");
      //       return PhotoViewPage(
      //         path: args!['path'],
      //         fromNet: args['fromNet'],
      //       );
      //     },
      //   );

      default:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
