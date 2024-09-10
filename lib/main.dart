import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/routers/app_router.dart';
import 'package:notify/core/style/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notify/features/auth/presentation/view/login/login_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initInjections();
  runApp(
      // DevicePreview(
      // enabled: true,
      // builder: (context) {
      //   return const
      // },
      const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ScreenUtilInit(
        designSize: Size(width, height),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRouter.generateRoute,
            title: 'Notify',
            theme: appTheme,
            darkTheme: darkAppTheme,
            home: const LoginPage(),
          );
        });
  }
}

