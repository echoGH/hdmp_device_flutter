/// 连接请求实体
class ConnectionRequest {
  String? deviceType;

  ConnectionRequest({this.deviceType});

  Map<String, dynamic> toJson() => {
        'deviceType': deviceType,
      };

  factory ConnectionRequest.fromJson(Map<String, dynamic> json) {
    return ConnectionRequest(
      deviceType: json['deviceType'] as String?,
    );
  }
}
