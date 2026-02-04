/// 通用响应基类
class BaseResponse<T> {
  String? code;
  String? message;
  T? data;
  bool? success;

  BaseResponse({
    this.code,
    this.message,
    this.data,
    this.success,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return BaseResponse<T>(
      code: json['code'] as String?,
      message: json['message'] as String?,
      data: fromJsonT != null && json['data'] != null
          ? fromJsonT(json['data'])
          : json['data'] as T?,
      success: json['success'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'data': data,
        'success': success,
      };
}
