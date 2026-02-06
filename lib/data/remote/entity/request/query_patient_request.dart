/// 患者请求参数
class QueryPatientRequest {
  final String customerActiveCode;
  final String? searchKeyword;
  final List<String>? wardIdList;
  final int page;
  final int pageSize;

  QueryPatientRequest({
    required this.customerActiveCode,
    this.searchKeyword,
    this.wardIdList,
    this.page = 1,
    this.pageSize = 40,
  });

  Map<String, dynamic> toJson() {
    return {
      'customerActiveCode': customerActiveCode,
      'searchKeyword': searchKeyword ?? '',
      'wardIdList': wardIdList ?? [],
      'page': page.toString(),
      'pageSize': pageSize.toString(),
    };
  }

  factory QueryPatientRequest.fromJson(Map<String, dynamic> json) {
    return QueryPatientRequest(
      customerActiveCode: json['customerActiveCode'] as String,
      searchKeyword: json['searchKeyword'] as String?,
      wardIdList: (json['wardIdList'] as List<dynamic>?)?.cast<String>(),
      page: int.parse(json['page'] as String),
      pageSize: int.parse(json['pageSize'] as String),
    );
  }
}