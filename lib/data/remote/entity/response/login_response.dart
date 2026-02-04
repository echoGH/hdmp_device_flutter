/// 登录响应实体（完全沿用Android项目）
class LoginResponse {
  String? code;
  String? message;
  LoginInfo? data;
  bool? success;

  LoginResponse({
    this.code,
    this.message,
    this.data,
    this.success,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      code: json['code'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? LoginInfo.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      success: json['success'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'data': data?.toJson(),
        'success': success,
      };
}

/// 登录信息
class LoginInfo {
  String? token;
  UserInfo? userInfo;

  LoginInfo({
    this.token,
    this.userInfo,
  });

  factory LoginInfo.fromJson(Map<String, dynamic> json) {
    return LoginInfo(
      token: json['token'] as String?,
      userInfo: json['userInfo'] != null
          ? UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'token': token,
        'userInfo': userInfo?.toJson(),
      };
}

/// 用户信息
class UserInfo {
  String? userId;
  String? account;
  String? userName;
  String? phone;
  String? userPassword;
  String? passwordSalt;
  String? createTime;
  String? status;
  String? isDefault;
  String? roleId;
  String? wardId;
  String? roleType;
  String? deptId;
  String? sex;
  String? sexs;
  String? roleTypes;
  String? deptName;
  String? wardName;
  int? customerId;
  String? customerName;
  String? statued;
  String? remark;
  bool? disableEdit;
  bool? disableStatus;
  bool? disableDelete;
  bool? reset;
  bool? admin;

  UserInfo({
    this.userId,
    this.account,
    this.userName,
    this.phone,
    this.userPassword,
    this.passwordSalt,
    this.createTime,
    this.status,
    this.isDefault,
    this.roleId,
    this.wardId,
    this.roleType,
    this.deptId,
    this.sex,
    this.sexs,
    this.roleTypes,
    this.deptName,
    this.wardName,
    this.customerId,
    this.customerName,
    this.statued,
    this.remark,
    this.disableEdit,
    this.disableStatus,
    this.disableDelete,
    this.reset,
    this.admin,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userId: json['userId'] as String?,
      account: json['account'] as String?,
      userName: json['userName'] as String?,
      phone: json['phone'] as String?,
      userPassword: json['userPassword'] as String?,
      passwordSalt: json['passwordSalt'] as String?,
      createTime: json['createTime'] as String?,
      status: json['status'] as String?,
      isDefault: json['isDefault'] as String?,
      roleId: json['roleId'] as String?,
      wardId: json['wardId'] as String?,
      roleType: json['roleType'] as String?,
      deptId: json['deptId'] as String?,
      sex: json['sex'] as String?,
      sexs: json['sexs'] as String?,
      roleTypes: json['roleTypes'] as String?,
      deptName: json['deptName'] as String?,
      wardName: json['wardName'] as String?,
      customerId: json['customerId'] as int?,
      customerName: json['customerName'] as String?,
      statued: json['statued'] as String?,
      remark: json['remark'] as String?,
      disableEdit: json['disableEdit'] as bool?,
      disableStatus: json['disableStatus'] as bool?,
      disableDelete: json['disableDelete'] as bool?,
      reset: json['reset'] as bool?,
      admin: json['admin'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'account': account,
        'userName': userName,
        'phone': phone,
        'userPassword': userPassword,
        'passwordSalt': passwordSalt,
        'createTime': createTime,
        'status': status,
        'isDefault': isDefault,
        'roleId': roleId,
        'wardId': wardId,
        'roleType': roleType,
        'deptId': deptId,
        'sex': sex,
        'sexs': sexs,
        'roleTypes': roleTypes,
        'deptName': deptName,
        'wardName': wardName,
        'customerId': customerId,
        'customerName': customerName,
        'statued': statued,
        'remark': remark,
        'disableEdit': disableEdit,
        'disableStatus': disableStatus,
        'disableDelete': disableDelete,
        'reset': reset,
        'admin': admin,
      };
}
