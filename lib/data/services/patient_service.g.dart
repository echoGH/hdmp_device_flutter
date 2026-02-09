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
  Future<BaseResponse<PatientPageList>> getPatientList(
    QueryPatientRequest request,
  ) {
    final queryParameters = <String, dynamic>{};
    final data = request.toJson();
    final path = '/framework/phoneappbgpat/getPatInfo';
    return _dio
        .post<Map<String, dynamic>>(
          path,
          data: data,
          queryParameters: queryParameters,
        )
        .then((response) {
          return BaseResponse.fromJson(
            response.data!,
            (json) => PatientPageList.fromJson(json),
          );
        });
  }

  @override
  Future<BaseResponse<PatientPageList>> getCgmPatientList(
    QueryPatientRequest request,
  ) {
    final queryParameters = <String, dynamic>{};
    final data = request.toJson();
    final path = '/framework/phoneappcommon/getCgmUsePatListWithPage';
    return _dio
        .post<Map<String, dynamic>>(
          path,
          data: data,
          queryParameters: queryParameters,
        )
        .then((response) {
          return BaseResponse.fromJson(
            response.data!,
            (json) => PatientPageList.fromJson(json),
          );
        });
  }

  @override
  Future<BaseResponse<PatientPageList>> getInsulinPumpPatientList(
    QueryPatientRequest request,
  ) {
    final queryParameters = <String, dynamic>{};
    final data = request.toJson();
    final path = '/framework/phoneappcommon/getCgmFinishPatListWithPage';
    return _dio
        .post<Map<String, dynamic>>(
          path,
          data: data,
          queryParameters: queryParameters,
        )
        .then((response) {
          return BaseResponse.fromJson(
            response.data!,
            (json) => PatientPageList.fromJson(json),
          );
        });
  }
}
