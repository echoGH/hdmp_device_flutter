import 'package:dio/dio.dart';
import '../../core/models/patient.dart';

/// 患者相关API服务 - 手动实现版本
class PatientService {
  final Dio _dio;

  PatientService(this._dio);

  /// 获取患者信息列表
  Future<PatientListResponse> getPatientList(PatientRequest request) async {
    try {
      final response = await _dio.post(
        '/framework/phoneappbgpat/getPatInfo',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return PatientListResponse.fromJson(data);
      } else {
        throw Exception('获取患者列表失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('获取患者列表异常: ${e.message}');
    } catch (e) {
      throw Exception('获取患者列表异常: $e');
    }
  }

  /// 获取CGM患者列表
  Future<PatientListResponse> getCgmPatientList(PatientRequest request) async {
    try {
      final response = await _dio.post(
        '/framework/phoneappcommon/getCgmUsePatListWithPage',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return PatientListResponse.fromJson(data);
      } else {
        throw Exception('获取CGM患者列表失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('获取CGM患者列表异常: ${e.message}');
    } catch (e) {
      throw Exception('获取CGM患者列表异常: $e');
    }
  }

  /// 获取胰岛素泵患者列表
  Future<PatientListResponse> getInsulinPumpPatientList(
    PatientRequest request,
  ) async {
    try {
      final response = await _dio.post(
        '/framework/phoneappcommon/getCgmFinishPatListWithPage',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return PatientListResponse.fromJson(data);
      } else {
        throw Exception('获取胰岛素泵患者列表失败: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('获取胰岛素泵患者列表异常: ${e.message}');
    } catch (e) {
      throw Exception('获取胰岛素泵患者列表异常: $e');
    }
  }
}

/// 患者请求参数
class PatientRequest {
  final String customerActiveCode;
  final String? searchKeyword;
  final List<String>? wardIdList;
  final int page;
  final int pageSize;

  PatientRequest({
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
}
