import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/login_provider_new.dart';

/// 登录页面（完全沿用Android项目的UI和逻辑）
class LoginPageNew extends ConsumerStatefulWidget {
  const LoginPageNew({super.key});

  @override
  ConsumerState<LoginPageNew> createState() => _LoginPageNewState();
}

class _LoginPageNewState extends ConsumerState<LoginPageNew> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  int _touchCount = 0;
  DateTime? _lastTouchTime;

  @override
  void initState() {
    super.initState();
    // 加载保存的用户名和密码
    _loadSavedCredentials();
    // 获取客户列表
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(loginProviderNew.notifier).getCustomers();
    });
  }

  void _loadSavedCredentials() async {
    final notifier = ref.read(loginProviderNew.notifier);
    await notifier.loadSavedCredentials();
    final state = ref.read(loginProviderNew);
    _usernameController.text = state.username;
    _passwordController.text = state.password;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  /// 检测连击5次进入设备设置
  void _handleTouch() {
    final now = DateTime.now();
    if (_lastTouchTime != null && now.difference(_lastTouchTime!).inSeconds > 2) {
      _touchCount = 0;
    }
    _touchCount++;
    _lastTouchTime = now;

    if (_touchCount >= 5) {
      _touchCount = 0;
      // 跳转到设备设置页面
      Navigator.of(context).pushNamed(AppConstants.routeDeviceSetting);
    }
  }

  /// 显示客户选择器
  void _showCustomerPicker() {
    final state = ref.read(loginProviderNew);
    if (state.customers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('暂无客户列表')),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 400.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          ),
          child: Column(
            children: [
              Container(
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.lineBg, width: 1),
                  ),
                ),
                child: Text(
                  '选择机构',
                  style: TextStyle(
                    fontSize: AppDimens.sp16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.color333333,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.customers.length,
                  itemBuilder: (context, index) {
                    final customer = state.customers[index];
                    final isSelected =
                        state.customerId == customer.customerId.toString();
                    return InkWell(
                      onTap: () {
                        ref
                            .read(loginProviderNew.notifier)
                            .selectCustomer(customer.customerId.toString());
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.clickBgBlue
                              : Colors.transparent,
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.lineBg,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                customer.customerName ?? '',
                                style: TextStyle(
                                  fontSize: AppDimens.sp14,
                                  color: AppColors.color333333,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check,
                                color: AppColors.colorPrimary,
                                size: 20.r,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 登录按钮点击
  void _handleLogin() async {
    // 取消焦点
    FocusScope.of(context).unfocus();

    final notifier = ref.read(loginProviderNew.notifier);
    final username = _usernameController.text;
    final password = _passwordController.text;

    // 检测是否是设备设置密码
    if (username.trim().toUpperCase() == AppConstants.deviceSettingUsername.toUpperCase()) {
      Navigator.of(context).pushNamed(AppConstants.routeDeviceSetting);
      return;
    }

    // 执行登录
    final success = await notifier.login(username, password);
    if (success && mounted) {
      // 登录成功，跳转到主页
      Navigator.of(context).pushReplacementNamed(AppConstants.routeMain);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginProviderNew);
  
    // 监听错误消息
    ref.listen<LoginStateNew>(loginProviderNew, (previous, next) {
      if (next.errorMessage != null && next.errorMessage!.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  
    return Scaffold(
      backgroundColor: AppColors.colorF1F4F5,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            // 顶部背景图片（250dp高度）
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 250.h,
              child: Image.asset(
                'assets/images/bg_login_bg.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // 如果图片不存在，使用渐变背景
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.colorPrimary,
                          AppColors.colorPrimary.withOpacity(0.8),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
  
            // 主内容
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 122.h),
  
                  // 标题
                  Text(
                    'Diabetes Management System',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
  
                  SizedBox(height: 30.h),
  
                  // 登录表单卡片
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 30.h),
  
                        // 机构选择（表单首行）
                        _buildCustomerSelector(state),
                        SizedBox(height: 10.h),
  
                        // 用户名输入框
                        _buildUsernameInput(),
                        SizedBox(height: 20.h),
  
                        // 密码输入框
                        _buildPasswordInput(),
                        SizedBox(height: 20.h),
  
                        // 登录按钮
                        _buildLoginButton(state),
                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
  
                  // 连击区域（用于进入设备设置）
                  GestureDetector(
                    onTap: _handleTouch,
                    child: Container(
                      height: 200.h,
                      color: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
  
            // 加载指示器
            if (state.isLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// 构建机构选择器（表单首行）
  Widget _buildCustomerSelector(LoginStateNew state) {
    // 如果没有客户列表，显示提示文本
    if (state.customers.isEmpty) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 25.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.colorF5F7FA,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: AppColors.colorDCDFE6, width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '机构',
                style: TextStyle(
                  fontSize: AppDimens.sp14,
                  color: AppColors.color999999,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.r,
              color: AppColors.color999999,
            ),
          ],
        ),
      );
    }

    final selectedCustomer = state.customers.firstWhere(
      (c) => c.customerId.toString() == state.customerId,
      orElse: () => state.customers.first,
    );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: AppColors.colorF5F7FA,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: AppColors.colorDCDFE6, width: 1),
      ),
      child: InkWell(
        onTap: _showCustomerPicker,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  selectedCustomer.customerName ?? '请选择机构',
                  style: TextStyle(
                    fontSize: AppDimens.sp14,
                    color: AppColors.color333333,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16.r,
                color: AppColors.color999999,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建用户名输入框
  Widget _buildUsernameInput() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: AppColors.colorF5F7FA,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: AppColors.colorDCDFE6, width: 1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.person,
            size: 20.r,
            color: AppColors.color999999,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: _usernameController,
              focusNode: _usernameFocus,
              style: TextStyle(
                fontSize: AppDimens.sp14,
                color: AppColors.color333333,
              ),
              decoration: InputDecoration(
                hintText: 'account',
                hintStyle: TextStyle(
                  fontSize: AppDimens.sp14,
                  color: AppColors.color999999,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (_usernameController.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _usernameController.clear();
                setState(() {});
              },
              child: Icon(
                Icons.clear,
                size: 18.r,
                color: AppColors.color999999,
              ),
            ),
        ],
      ),
    );
  }

  /// 构建密码输入框
  Widget _buildPasswordInput() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: AppColors.colorF5F7FA,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: AppColors.colorDCDFE6, width: 1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.lock,
            size: 20.r,
            color: AppColors.color999999,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: _passwordController,
              focusNode: _passwordFocus,
              obscureText: true,
              style: TextStyle(
                fontSize: AppDimens.sp14,
                color: AppColors.color333333,
              ),
              decoration: InputDecoration(
                hintText: 'password',
                hintStyle: TextStyle(
                  fontSize: AppDimens.sp14,
                  color: AppColors.color999999,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (_passwordController.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _passwordController.clear();
                setState(() {});
              },
              child: Icon(
                Icons.clear,
                size: 18.r,
                color: AppColors.color999999,
              ),
            ),
        ],
      ),
    );
  }

  /// 构建登录按钮
  Widget _buildLoginButton(LoginStateNew state) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      width: double.infinity,
      height: 45.h,
      child: ElevatedButton(
        onPressed: state.isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.colorPrimary,
          disabledBackgroundColor: AppColors.colorPrimary.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
          elevation: 0,
        ),
        child: state.isLoading
            ? SizedBox(
                width: 20.r,
                height: 20.r,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                ),
              )
            : Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: AppDimens.sp15,
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );
  }
}
