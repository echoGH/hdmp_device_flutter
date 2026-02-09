import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constants/app_constants.dart';

/// Dio网络客户端（单例模式）
class DioClient {
  static DioClient? _instance;
  late Dio _dio;

  DioClient._() {
    _dio = Dio(_baseOptions);
    _setupInterceptors();
  }

  static DioClient get instance {
    _instance ??= DioClient._();
    return _instance!;
  }

  Dio get dio => _dio;

  /// 基础配置
  BaseOptions get _baseOptions => BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: Duration(milliseconds: AppConstants.connectTimeout),
        receiveTimeout: Duration(milliseconds: AppConstants.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

  /// 配置拦截器
  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 请求拦截
          if (kDebugMode) {
            print('请求URL: ${options.baseUrl}${options.path}');
            print('请求方法: ${options.method}');
            print('请求头: ${options.headers}');
            print('请求参数: ${options.data}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // 响应拦截
          if (kDebugMode) {
            print('响应状态码: ${response.statusCode}');
            print('响应数据: ${response.data}');
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          // 错误拦截
          if (kDebugMode) {
            print('请求错误: ${error.message}');
            print('错误响应: ${error.response?.data}');
          }
          return handler.next(error);
        },
      ),
    );
  }

  /// 添加Token到请求头
  void setToken(String token) {
    _dio.options.headers['token'] = token;
  }

  /// 清除Token
  void clearToken() {
    _dio.options.headers.remove('token');
  }
}
