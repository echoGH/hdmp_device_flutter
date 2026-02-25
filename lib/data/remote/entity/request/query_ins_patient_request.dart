/// 胰岛素泵患者请求参数
class QueryInsPatientRequest {
  final String customerActiveCode;
  final String? testHour;
  final int page;
  final int pageSize;

  QueryInsPatientRequest({
    required this.customerActiveCode,
    this.testHour,
    this.page = 1,
    this.pageSize = 40,
  });

  Map<String, dynamic> toJson() {
    return {
      'customerActiveCode': customerActiveCode,
      'testHour': testHour ?? '',
      'page': page.toString(),
      'pageSize': pageSize.toString(),
    };
  }

  factory QueryInsPatientRequest.fromJson(Map<String, dynamic> json) {
    return QueryInsPatientRequest(
      customerActiveCode: json['customerActiveCode'] as String,
      testHour: json['testHour'] as String?,
      page: int.parse(json['page'] as String),
      pageSize: int.parse(json['pageSize'] as String),
    );
  }
}