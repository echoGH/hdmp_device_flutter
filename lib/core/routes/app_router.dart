import 'package:go_router/go_router.dart';
import '../../presentation/pages/splash/splash_page.dart';
import '../../presentation/pages/login/login_page.dart';
import '../../presentation/pages/main/main_page.dart';

/// 路由配置
class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String main = '/main';
  static const String patientList = '/patient-list';
  static const String patientDetail = '/patient-detail';
  static const String measurement = '/measurement';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashPage()),
      GoRoute(path: login, builder: (context, state) => const LoginPage()),
      GoRoute(path: main, builder: (context, state) => const MainPage()),
    ],
  );
}
