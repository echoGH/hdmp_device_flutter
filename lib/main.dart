import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/app_colors.dart';
import 'presentation/pages/splash/splash_page.dart';
import 'presentation/pages/login/login_page.dart';
import 'presentation/pages/main/main_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: AppConstants.appName,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.colorPrimary, brightness: Brightness.light),
            scaffoldBackgroundColor: AppColors.activityBg,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: AppConstants.routeSplash,
          routes: {AppConstants.routeSplash: (context) => const SplashPage(), AppConstants.routeLogin: (context) => const LoginPage(), AppConstants.routeMain: (context) => const MainPage()},
        );
      },
    );
  }
}
