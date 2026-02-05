/// 登录响应实体（完全沿用Android项目）
class LoginResponse {
  int? code;
  String? message;
  LoginInfo? data;
  bool? success;

  LoginResponse({this.code, this.message, this.data, this.success});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      code: json['code'] as int?,
      message: json['msg'] as String?,
      data: json['data'] != null ? LoginInfo.fromJson(json['data'] as Map<String, dynamic>) : null,
      success: (json['code'] as int?) == 0,
    );
  }

  Map<String, dynamic> toJson() => {'code': code, 'message': message, 'data': data?.toJson(), 'success': success};
}

/// 登录信息
class LoginInfo {
  String? token;
  UserInfo? userInfo;

  LoginInfo({this.token, this.userInfo});

  factory LoginInfo.fromJson(Map<String, dynamic> json) {
    return LoginInfo(token: json['token'] as String?, userInfo: json['userLogin'] != null ? UserInfo.fromJson(json['userLogin'] as Map<String, dynamic>) : null);
  }

  Map<String, dynamic> toJson() => {'token': token, 'userInfo': userInfo?.toJson()};
}

/// 用户信息
class UserInfo {
  String? customerId;
  String? userId;
  String? userName;
  String? account;
  String? deptName;
  String? wardName;
  String? customerName;
  String? sex;

  UserInfo({this.customerId, this.userId, this.userName, this.account, this.deptName, this.wardName, this.customerName, this.sex});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      customerId: (json['customerId'] as int?).toString(),
      userId: json['userId'] as String,
      userName: json['userName'] as String?,
      account: json['account'] as String?,
      deptName: json['deptName'] != null ? json['deptName'] as String? : "",
      wardName: json['wardName'] != null ? json['wardName'] as String? : "",
      customerName: json['customerName'] != null ? json['customerName'] as String? : "",
      sex: json['sex'] != null ? json['sex'] as String? : "",
    );
  }

  Map<String, dynamic> toJson() => {
    'customerId': customerId,
    'userId': userId,
    'userName': userName,
    'account': account,
    'deptName': deptName,
    'wardName': wardName,
    'customerName': customerName,
    'sex': sex,
  };
}
