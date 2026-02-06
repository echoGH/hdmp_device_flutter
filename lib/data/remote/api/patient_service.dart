import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/models/patient.dart';
import '../entity/request/query_patient_request.dart';

part '../../services/patient_service.g.dart';

/// 患者相关API服务 - 与login一致的retrofit实现
@RestApi()
abstract class PatientService {
  factory PatientService(Dio dio, {String baseUrl}) = _PatientService;

  /// 获取患者信息列表
  @POST('/framework/phoneappbgpat/getPatInfo')
  Future<PatientListResponse> getPatientList(@Body() QueryPatientRequest request);

  /// 获取CGM患者列表
  @POST('/framework/phoneappcommon/getCgmUsePatListWithPage')
  Future<PatientListResponse> getCgmPatientList(@Body() QueryPatientRequest request);

  /// 获取胰岛素泵患者列表
  @POST('/framework/phoneappcommon/getCgmFinishPatListWithPage')
  Future<PatientListResponse> getInsulinPumpPatientList(
    @Body() QueryPatientRequest request,
  );
}
