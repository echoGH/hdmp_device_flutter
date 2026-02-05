/// 客户信息实体
class CustomerInfo {
  String? customerId;
  String? customerName;
  String? customerCode;
  String? parentCustomerId;

  CustomerInfo({
    this.customerId,
    this.customerName,
    this.customerCode,
    this.parentCustomerId,
  });

  factory CustomerInfo.fromJson(Map<String, dynamic> json) {
    return CustomerInfo(
      customerId: (json['customerId'] as int?).toString(),
      customerName: json['customerName'] as String?,
      customerCode: json['customerCode'] as String?,
      parentCustomerId: (json['parentCustomerId'] as int?).toString()
    );
  }

  Map<String, dynamic> toJson() => {
        'customerId': customerId,
        'customerName': customerName,
        'customerCode': customerCode,
        'parentCustomerId': parentCustomerId,
      };
}
