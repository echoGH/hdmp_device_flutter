import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../providers/login_provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';

/// 登录页面
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // 加载客户列表
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(loginProvider.notifier).loadCustomers();
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// 处理登录
  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await ref.read(loginProvider.notifier).login();
      
      if (success && mounted) {
        // 登录成功，跳转到主页
        Navigator.of(context).pushReplacementNamed(AppConstants.routeMain);
      } else {
        // 显示错误信息
        final errorMessage = ref.read(loginProvider).errorMessage;
        if (errorMessage != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    
    // 同步controller的值
    if (_usernameController.text != loginState.username) {
      _usernameController.text = loginState.username;
    }
    if (_passwordController.text != loginState.password) {
      _passwordController.text = loginState.password;
    }

    return Scaffold(
      body: Stack(
        children: [
          // 背景
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.primaryColor,
                  AppTheme.backgroundColor,
                ],
                stops: [0.0, 0.4],
              ),
            ),
          ),
          
          // 内容
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 122.h),
                  
                  // 标题
                  Text(
                    AppConstants.appName,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  
                  SizedBox(height: 30.h),
                  
                  // 登录表单卡片
                  _buildLoginCard(loginState),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建登录卡片
  Widget _buildLoginCard(LoginState loginState) {
    return Container(
      padding: EdgeInsets.all(25.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 客户选择（如果有客户列表）
            if (loginState.customers.isNotEmpty) ...[
              _buildCustomerSelector(loginState),
              SizedBox(height: 10.h),
            ],
            
            // 用户名输入框
            _buildUsernameField(),
            
            SizedBox(height: 20.h),
            
            // 密码输入框
            _buildPasswordField(),
            
            SizedBox(height: 20.h),
            
            // 登录按钮
            _buildLoginButton(loginState.isLoading),
            
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  /// 构建客户选择器
  Widget _buildCustomerSelector(LoginState loginState) {
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.borderColor),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: InkWell(
        onTap: () => _showCustomerPicker(loginState.customers),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  loginState.customerId != null
                      ? loginState.customers
                          .firstWhere((c) => c.customerId == loginState.customerId)
                          .customerName
                      : '请选择客户',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: loginState.customerId != null
                        ? AppTheme.textPrimaryColor
                        : AppTheme.textHintColor,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 14.sp,
                color: AppTheme.textSecondaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 显示客户选择器
  void _showCustomerPicker(List<CustomerInfo> customers) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: customers.length,
          itemBuilder: (context, index) {
            final customer = customers[index];
            return ListTile(
              title: Text(customer.customerName),
              onTap: () {
                ref.read(loginProvider.notifier).selectCustomer(customer.customerId);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  /// 构建用户名输入框
  Widget _buildUsernameField() {
    return TextFormField(
      controller: _usernameController,
      decoration: InputDecoration(
        hintText: '请输入用户名',
        prefixIcon: const Icon(Icons.person_outline),
        suffixIcon: _usernameController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _usernameController.clear();
                  ref.read(loginProvider.notifier).updateUsername('');
                },
              )
            : null,
      ),
      onChanged: (value) {
        ref.read(loginProvider.notifier).updateUsername(value);
        setState(() {}); // 更新清除按钮显示
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '用户名不能为空';
        }
        return null;
      },
    );
  }

  /// 构建密码输入框
  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        hintText: '请输入密码',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: _passwordController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _passwordController.clear();
                  ref.read(loginProvider.notifier).updatePassword('');
                },
              )
            : null,
      ),
      obscureText: true,
      onChanged: (value) {
        ref.read(loginProvider.notifier).updatePassword(value);
        setState(() {}); // 更新清除按钮显示
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '密码不能为空';
        }
        return null;
      },
    );
  }

  /// 构建登录按钮
  Widget _buildLoginButton(bool isLoading) {
    return ElevatedButton(
      onPressed: isLoading ? null : _handleLogin,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 45.h),
      ),
      child: isLoading
          ? SizedBox(
              height: 20.h,
              width: 20.h,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              '登录',
              style: TextStyle(fontSize: 15.sp),
            ),
    );
  }
}
