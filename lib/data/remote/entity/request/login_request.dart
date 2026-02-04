/// 登录请求实体（完全沿用Android项目）
class LoginRequest {
  String? customerId;
  String? account;
  String? userPassword;

  LoginRequest({
    this.customerId,
    this.account,
    this.userPassword,
  });

  Map<String, dynamic> toJson() => {
        'customerId': customerId,
        'account': account,
        'userPassword': userPassword,
      };

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      customerId: json['customerId'] as String?,
      account: json['account'] as String?,
      userPassword: json['userPassword'] as String?,
    );
  }
}
