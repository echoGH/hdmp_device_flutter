/// 分页返回信息
class PageInfo {
  final int? totalCount;
  final int? pageSize;
  final int? totalPage;
  final int? currPage;

  const PageInfo({this.totalCount, this.pageSize, this.totalPage, this.currPage});
}
