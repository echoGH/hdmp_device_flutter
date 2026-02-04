import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

/// 登录状态
class LoginState {
  final bool isLoading;
  final String? errorMessage;
  final String username;
  final String password;
  final String? customerId;
  final List<CustomerInfo> customers;

  const LoginState({
    this.isLoading = false,
    this.errorMessage,
    this.username = '',
    this.password = '',
    this.customerId,
    this.customers = const [],
  });

  LoginState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? username,
    String? password,
    String? customerId,
    List<CustomerInfo>? customers,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      username: username ?? this.username,
      password: password ?? this.password,
      customerId: customerId ?? this.customerId,
      customers: customers ?? this.customers,
    );
  }
}

/// 客户信息
class CustomerInfo {
  final String customerId;
  final String customerName;

  const CustomerInfo({
    required this.customerId,
    required this.customerName,
  });
}

/// 登录Provider
class LoginNotifier extends Notifier<LoginState> {
  @override
  LoginState build() {
    _loadSavedCredentials();
    return const LoginState();
  }

  /// 加载保存的凭据
  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(AppConstants.keyUsername) ?? '';
    final password = prefs.getString(AppConstants.keyPassword) ?? '';
    
    state = state.copyWith(
      username: username,
      password: password,
    );
  }

  /// 更新用户名
  void updateUsername(String username) {
    state = state.copyWith(username: username);
  }

  /// 更新密码
  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  /// 选择客户
  void selectCustomer(String customerId) {
    state = state.copyWith(customerId: customerId);
  }

  /// 执行登录
  Future<bool> login() async {
    if (state.username.trim().isEmpty) {
      state = state.copyWith(errorMessage: '请输入用户名');
      return false;
    }

    if (state.password.trim().isEmpty) {
      state = state.copyWith(errorMessage: '请输入密码');
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // TODO: 实际的登录API调用
      // 模拟网络请求
      await Future.delayed(const Duration(seconds: 1));

      // 保存凭据
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.keyUsername, state.username);
      await prefs.setString(AppConstants.keyPassword, state.password);
      
      if (state.customerId != null) {
        await prefs.setString(AppConstants.keyCustomerId, state.customerId!);
      }
      
      // 模拟token
      await prefs.setString(AppConstants.keyToken, 'mock_token_${DateTime.now().millisecondsSinceEpoch}');

      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '登录失败: ${e.toString()}',
      );
      return false;
    }
  }

  /// 加载客户列表
  Future<void> loadCustomers() async {
    try {
      // TODO: 实际的API调用
      // 模拟客户数据
      final customers = [
        const CustomerInfo(customerId: '1', customerName: '客户1'),
        const CustomerInfo(customerId: '2', customerName: '客户2'),
      ];

      state = state.copyWith(customers: customers);
    } catch (e) {
      // 处理错误
    }
  }
}

/// 登录Provider实例
final loginProvider = NotifierProvider<LoginNotifier, LoginState>(() {
  return LoginNotifier();
});
