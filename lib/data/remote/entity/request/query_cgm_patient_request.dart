/// CGM患者请求参数
class QueryCGMPatientRequest {
  final String customerActiveCode;
  final String? testHour;
  final List<String>? wardIdList;
  final int page;
  final int pageSize;

  QueryCGMPatientRequest({
    required this.customerActiveCode,
    this.testHour,
    this.wardIdList,
    this.page = 1,
    this.pageSize = 40,
  });

  Map<String, dynamic> toJson() {
    return {
      'customerActiveCode': customerActiveCode,
      'testHour': testHour ?? '',
      'wardIdList': wardIdList ?? [],
      'page': page.toString(),
      'pageSize': pageSize.toString(),
    };
  }

  factory QueryCGMPatientRequest.fromJson(Map<String, dynamic> json) {
    return QueryCGMPatientRequest(
      customerActiveCode: json['customerActiveCode'] as String,
      testHour: json['testHour'] as String?,
      wardIdList: (json['wardIdList'] as List<dynamic>?)?.cast<String>(),
      page: int.parse(json['page'] as String),
      pageSize: int.parse(json['pageSize'] as String),
    );
  }
}