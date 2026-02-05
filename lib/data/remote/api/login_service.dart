import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../entity/request/login_request.dart';
import '../entity/request/connection_request.dart';
import '../entity/response/login_response.dart';
import '../entity/response/base_response.dart';
import '../../entity/customer_info.dart';

part 'login_service.g.dart';

/// 登录相关API服务
@RestApi()
abstract class LoginService {
  factory LoginService(Dio dio, {String baseUrl}) = _LoginService;

  /// 用户登录
  @POST('/framework/phoneapplogin/login')
  Future<LoginResponse> login(@Body() LoginRequest request);

  /// 连接测试
  @POST('/framework/syncMobile/connection')
  Future<BaseResponse> connection(@Body() ConnectionRequest request);

  /// 获取所有有效的客户列表
  @POST('/framework/phoneappcommon/getAllEffectiveCustomerList')
  Future<BaseResponse<List<CustomerInfo>>> getAllEffectiveCustomerList(@Body() ConnectionRequest request);
}
