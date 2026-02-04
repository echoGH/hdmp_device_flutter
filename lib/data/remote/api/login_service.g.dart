// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _LoginService implements LoginService {
  _LoginService(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = request.toJson();
    final _result = await _dio.fetch<Map<String, dynamic>>(
      _setStreamType<LoginResponse>(Options(
        method: 'POST',
        headers: _headers,
        extra: _extra,
      )
          .compose(
            _dio.options,
            '/framework/phoneapplogin/login',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)),
    );
    final value = LoginResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResponse> connection(ConnectionRequest request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = request.toJson();
    final _result = await _dio.fetch<Map<String, dynamic>>(
      _setStreamType<BaseResponse>(Options(
        method: 'POST',
        headers: _headers,
        extra: _extra,
      )
          .compose(
            _dio.options,
            '/framework/syncMobile/connection',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)),
    );
    final value = BaseResponse.fromJson(_result.data!, null);
    return value;
  }

  @override
  Future<BaseResponse<List<CustomerInfo>>> getAllEffectiveCustomerList(
      ConnectionRequest request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = request.toJson();
    final _result = await _dio.fetch<Map<String, dynamic>>(
      _setStreamType<BaseResponse<List<CustomerInfo>>>(Options(
        method: 'POST',
        headers: _headers,
        extra: _extra,
      )
          .compose(
            _dio.options,
            '/framework/phoneappcommon/getAllEffectiveCustomerList',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)),
    );
    final value = BaseResponse<List<CustomerInfo>>.fromJson(
      _result.data!,
      (json) => (json as List).map((e) => CustomerInfo.fromJson(e as Map<String, dynamic>)).toList(),
    );
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
