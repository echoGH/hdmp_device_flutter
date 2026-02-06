import 'package:dio/dio.dart';
import 'package:hdmp_device_flutter/data/remote/entity/request/query_patient_request.dart';
import 'package:retrofit/retrofit.dart';
import '../entity/response/base_response.dart';

part '../../services/patient_service.g.dart';

/// 患者相关API服务
@RestApi()
abstract class PatientService {
  factory PatientService(Dio dio, {String baseUrl}) = _PatientService;

  /// 获取患者信息列表
  @POST('/framework/phoneappbgpat/getPatInfo')
  Future<BaseResponse> getPatientList(@Body() QueryPatientRequest request);

  /// 获取CGM患者列表
  @POST('/framework/phoneappcommon/getCgmUsePatListWithPage')
  Future<BaseResponse> getCgmPatientList(@Body() QueryPatientRequest request);

  /// 获取胰岛素泵患者列表
  @POST('/framework/phoneappcommon/getCgmFinishPatListWithPage')
  Future<BaseResponse> getInsulinPumpPatientList(@Body() QueryPatientRequest request);
}
