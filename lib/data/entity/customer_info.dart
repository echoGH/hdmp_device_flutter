/// 客户信息实体（完全沿用Android项目的CustomerInfos）
class CustomerInfo {
  int? customerId;
  String? customerName;
  String? customerCode;
  String? address;
  String? phone;
  String? status;
  String? createTime;
  String? updateTime;

  CustomerInfo({
    this.customerId,
    this.customerName,
    this.customerCode,
    this.address,
    this.phone,
    this.status,
    this.createTime,
    this.updateTime,
  });

  factory CustomerInfo.fromJson(Map<String, dynamic> json) {
    return CustomerInfo(
      customerId: json['customerId'] as int?,
      customerName: json['customerName'] as String?,
      customerCode: json['customerCode'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      status: json['status'] as String?,
      createTime: json['createTime'] as String?,
      updateTime: json['updateTime'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'customerId': customerId,
        'customerName': customerName,
        'customerCode': customerCode,
        'address': address,
        'phone': phone,
        'status': status,
        'createTime': createTime,
        'updateTime': updateTime,
      };
}
