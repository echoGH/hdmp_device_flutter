// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../remote/api/patient_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _PatientService implements PatientService {
  final Dio _dio;
  final String? _baseUrl;

  _PatientService(this._dio, {String? baseUrl}) : _baseUrl = baseUrl;

  @override
  Future<BaseResponse<PatientPageList>> getPatientList(QueryPatientRequest request) {
    final queryParameters = <String, dynamic>{};
    final data = request.toJson();
    final path = '/framework/phoneappbgpat/getPatInfo';
    return _dio.post<Map<String, dynamic>>(path, data: data, queryParameters: queryParameters).then((response) {
      return BaseResponse.fromJson(response.data!, (json) => PatientPageList.fromJson(json));
    });
  }

  @override
  Future<BaseResponse<CGMPatientPageList>> getCgmUsePatientList(QueryCGMPatientRequest request) {
    final queryParameters = <String, dynamic>{};
    final data = request.toJson();
    final path = '/framework/phoneappcommon/getCgmUsePatListWithPage';
    return _dio.post<Map<String, dynamic>>(path, data: data, queryParameters: queryParameters).then((response) {
      return BaseResponse.fromJson(response.data!, (json) => CGMPatientPageList.fromJson(json));
    });
  }

  @override
  Future<BaseResponse<CGMPatientPageList>> getCgmFinishPatientList(QueryCGMPatientRequest request) {
    final queryParameters = <String, dynamic>{};
    final data = request.toJson();
    final path = '/framework/phoneappcommon/getCgmFinishPatListWithPage';
    return _dio.post<Map<String, dynamic>>(path, data: data, queryParameters: queryParameters).then((response) {
      return BaseResponse.fromJson(response.data!, (json) => CGMPatientPageList.fromJson(json));
    });
  }

  @override
  Future<BaseResponse<InsPatientPageList>> getInsulinPumpPatientList(QueryInsPatientRequest request) {
    final queryParameters = <String, dynamic>{};
    final data = request.toJson();
    final path = '/framework/phoneappinsulinpump/getInsulinPumpRecordCardWithPage';
    return _dio.post<Map<String, dynamic>>(path, data: data, queryParameters: queryParameters).then((response) {
      return BaseResponse.fromJson(response.data!, (json) => InsPatientPageList.fromJson(json));
    });
  }
}
