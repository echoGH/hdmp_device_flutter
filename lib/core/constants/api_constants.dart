// API常量配置
class ApiConstants {
  // 基础URL
  static const String baseUrl = 'http://192.168.187.18:7009/';
  
  // API端点
  static const String login = '/api/auth/login';
  static const String patientList = '/api/patient/list';
  static const String bloodGlucose = '/api/blood/glucose';
  
  // 超时配置
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
}
