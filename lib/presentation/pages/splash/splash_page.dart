import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../../core/constants/app_constants.dart';

/// Splash启动页
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  /// 延迟后跳转到登录页
  Future<void> _navigateToLogin() async {
    // 等待2秒后跳转到登录页
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.of(context).pushReplacementNamed(AppConstants.routeLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 项目启动图标
            Image.asset(
              'assets/icons/ic_launcher.png',
              width: 80,
              height: 80,
              errorBuilder: (context, error, stackTrace) {
                // 如果图片加载失败，降级为Icon
                return const Icon(Icons.medical_services, size: 80, color: Color(0xFF4A90E2));
              },
            ),
            const SizedBox(height: 20),
            const Text(
              AppConstants.appName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
