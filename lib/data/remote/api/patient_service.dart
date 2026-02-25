import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/cgm_patient.dart';
import '../../models/ins_patient.dart';
import '../../models/patient.dart';
import '../entity/request/query_cgm_patient_request.dart';
import '../entity/request/query_ins_patient_request.dart';
import '../entity/request/query_patient_request.dart';
import '../entity/response/base_response.dart';

part '../../services/patient_service.g.dart';

/// 患者相关API服务
@RestApi()
abstract class PatientService {
  factory PatientService(Dio dio, {String baseUrl}) = _PatientService;

  /// 获取患者信息列表
  @POST('/framework/phoneappbgpat/getPatInfo')
  Future<BaseResponse<PatientPageList>> getPatientList(@Body() QueryPatientRequest request);

  /// 获取使用中CGM患者列表
  @POST('/framework/phoneappcommon/getCgmUsePatListWithPage')
  Future<BaseResponse<CGMPatientPageList>> getCgmUsePatientList(@Body() QueryCGMPatientRequest request);

  /// 获取已完成CGM患者列表
  @POST('/framework/phoneappcommon/getCgmFinishPatListWithPage')
  Future<BaseResponse<CGMPatientPageList>> getCgmFinishPatientList(@Body() QueryCGMPatientRequest request);

  /// 获取胰岛素泵患者列表
  @POST('/framework/phoneappinsulinpump/getInsulinPumpRecordCardWithPage')
  Future<BaseResponse<InsPatientPageList>> getInsulinPumpPatientList(@Body() QueryInsPatientRequest request);
}
