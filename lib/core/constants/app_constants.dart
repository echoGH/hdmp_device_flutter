/// 应用常量配置
class AppConstants {
  AppConstants._();

  // 应用信息
  static const String appName = 'HDMP医疗设备管理系统';
  static const String version = '1.0.10';

  // API 配置
  static const String baseUrl = 'http://192.168.187.18:7009/';
  
  // SharedPreferences Keys
  static const String keyUsername = 'userNanme';
  static const String keyPassword = 'userPass';
  static const String keyToken = 'token';
  static const String keyCustomerId = 'customerId';
  
  // 设备设置密码
  static const String deviceSettingUsername = 'devicesetting';
  
  // 超时配置
  static const int connectTimeout = 30000; // 30秒
  static const int receiveTimeout = 30000;
  
  // 页面路由
  static const String routeSplash = '/';
  static const String routeLogin = '/login';
  static const String routeMain = '/main';
  static const String routeDeviceSetting = '/device-setting';
}
