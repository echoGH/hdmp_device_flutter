/// 查询患者列表请求实体
class QueryPatientRequest {
  String customerActiveCode;
  String? searchKeyword;
  List<String>? wardIdList;
  int page;
  int pageSize;

  QueryPatientRequest({required this.customerActiveCode, this.searchKeyword, this.wardIdList, required this.page, required this.pageSize});

  Map<String, dynamic> toJson() => {'customerActiveCode': customerActiveCode, 'searchKeyword': searchKeyword ?? '', 'wardIdList': wardIdList ?? [], 'page': page, 'pageSize': pageSize};

  factory QueryPatientRequest.fromJson(Map<String, dynamic> json) {
    return QueryPatientRequest(
      customerActiveCode: json['customerActiveCode'] as String,
      searchKeyword: json['searchKeyword'] as String?,
      wardIdList: json['wardIdList'] as List<String>?,
      page: json['page'] as int,
      pageSize: json['pageSize'] as int,
    );
  }
}
