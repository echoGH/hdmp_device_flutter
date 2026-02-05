import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/dio_client.dart';
import '../../core/utils/crypto_utils.dart';
import '../../data/entity/customer_info.dart';
import '../../data/remote/api/login_service.dart';
import '../../data/remote/entity/request/connection_request.dart';
import '../../data/remote/entity/request/login_request.dart';

/// 登录状态
class LoginState {
  final bool isLoading;
  final String? errorMessage;
  final String username;
  final String password;
  final String customerId;
  final List<CustomerInfo> customers;
  final String? token;

  const LoginState({this.isLoading = false, this.errorMessage, this.username = '', this.password = '', this.customerId = '', this.customers = const [], this.token});

  LoginState copyWith({bool? isLoading, String? errorMessage, String? username, String? password, String? customerId, List<CustomerInfo>? customers, String? token}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      username: username ?? this.username,
      password: password ?? this.password,
      customerId: customerId ?? this.customerId,
      customers: customers ?? this.customers,
      token: token ?? this.token,
    );
  }
}

/// 登录Provider
class LoginNotifier extends Notifier<LoginState> {
  late LoginService _loginService;

  @override
  LoginState build() {
    _loginService = LoginService(DioClient.instance.dio);
    return const LoginState();
  }

  /// 加载保存的用户凭据
  Future<void> loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(AppConstants.keyUsername) ?? '';
    final password = prefs.getString(AppConstants.keyPassword) ?? '';
    final customerId = prefs.getString(AppConstants.keyCustomerId) ?? '';

    state = state.copyWith(username: username, password: password, customerId: customerId);
  }

  /// 保存用户凭据
  Future<void> _saveCredentials(String username, String password, String customerId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.keyUsername, username);
    await prefs.setString(AppConstants.keyPassword, password);
    await prefs.setString(AppConstants.keyCustomerId, customerId);
  }

  /// 获取机构列表
  Future<void> getCustomers() async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);

      final request = ConnectionRequest(deviceType: '1'); // Android设备类型为1
      final response = await _loginService.getAllEffectiveCustomerList(request);

      if (response.success == true && response.data != null) {
        state = state.copyWith(isLoading: false, customers: response.data!, customerId: response.data!.isNotEmpty ? response.data!.first.customerId.toString() : '');
      } else {
        state = state.copyWith(isLoading: false, errorMessage: response.message ?? '获取机构列表失败');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: '获取客户机构异常: $e');
    }
  }

  /// 选择客户
  void selectCustomer(String customerId) {
    state = state.copyWith(customerId: customerId);
  }

  /// 执行登录
  Future<bool> login(String username, String password) async {
    // 验证输入
    if (username.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Username can\'t be empty');
      return false;
    }

    if (password.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Password can\'t be empty');
      return false;
    }

    // 检查客户ID
    if (state.customers.isNotEmpty && state.customerId.isEmpty) {
      state = state.copyWith(errorMessage: '请选择客户');
      return false;
    }

    try {
      state = state.copyWith(isLoading: true, errorMessage: null);

      // AES加密密码（完全沿用Android项目的加密方式）
      final encryptedPassword = CryptoUtils.encryptAES(password);

      // 构建登录请求
      final request = LoginRequest(customerId: state.customerId, account: username, userPassword: encryptedPassword);

      // 调用登录API
      final response = await _loginService.login(request);

      if (response.success == true && response.data != null) {
        // 登录成功
        final token = response.data!.token ?? '';
        final userInfo = response.data!.userInfo;

        // 保存Token
        if (token.isNotEmpty) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(AppConstants.keyToken, token);
          DioClient.instance.setToken(token);
        }

        // 保存用户凭据
        await _saveCredentials(username, password, state.customerId);

        state = state.copyWith(isLoading: false, token: token, username: username, password: password);

        return true;
      } else {
        // 登录失败
        state = state.copyWith(isLoading: false, errorMessage: response.message ?? 'Login failed');
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: 'Login exception: $e');
      return false;
    }
  }

  /// 清除错误消息
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// 登录Provider实例
final loginProvider = NotifierProvider<LoginNotifier, LoginState>(() {
  return LoginNotifier();
});
