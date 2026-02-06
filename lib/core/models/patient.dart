/// 患者基本信息
class Patient {
  /// 患者ID
  final String patientId;

  /// 住院流水号
  final String inSerialId;

  /// 患者姓名
  final String patientName;

  /// 床号
  final String bedCode;

  /// 性别描述
  final String? sexDesc;

  /// 年龄描述
  final String? ageDesc;

  /// 科室名称
  final String? deptName;

  /// 病区名称
  final String? wardName;

  /// 是否CGM患者 (1:是, 0:否)
  final String? isCgm;

  /// 是否胰岛素泵患者 (1:是, 0:否)
  final String? isInsulinPump;

  /// 血糖计划数
  final String? bgmPlanNum;

  /// 血糖完成数
  final String? bgmPlanFinishNum;

  /// 入院日期
  final String? admDate;

  /// 访问ID
  final String? visitId;

  /// 最近检测信息
  final TestInfo? testInfo;

  Patient({
    required this.patientId,
    required this.inSerialId,
    required this.patientName,
    required this.bedCode,
    this.sexDesc,
    this.ageDesc,
    this.deptName,
    this.wardName,
    this.isCgm,
    this.isInsulinPump,
    this.bgmPlanNum,
    this.bgmPlanFinishNum,
    this.admDate,
    this.visitId,
    this.testInfo,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      patientId: json['patientId'] as String,
      inSerialId: json['inSerialId'] as String,
      patientName: json['patientName'] as String,
      bedCode: json['bedCode'] as String,
      sexDesc: json['sexDesc'] as String?,
      ageDesc: json['ageDesc'] as String?,
      deptName: json['deptName'] as String?,
      wardName: json['wardName'] as String?,
      isCgm: json['isCgm'] as String?,
      isInsulinPump: json['isInsulinPump'] as String?,
      bgmPlanNum: json['bgmPlanNum'] as String?,
      bgmPlanFinishNum: json['bgmPlanFinishNum'] as String?,
      admDate: json['admDate'] as String?,
      visitId: json['visitId'] as String?,
      testInfo: json['testInfo'] != null
          ? TestInfo.fromJson(json['testInfo'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'inSerialId': inSerialId,
      'patientName': patientName,
      'bedCode': bedCode,
      'sexDesc': sexDesc,
      'ageDesc': ageDesc,
      'deptName': deptName,
      'wardName': wardName,
      'isCgm': isCgm,
      'isInsulinPump': isInsulinPump,
      'bgmPlanNum': bgmPlanNum,
      'bgmPlanFinishNum': bgmPlanFinishNum,
      'admDate': admDate,
      'visitId': visitId,
      'testInfo': testInfo?.toJson(),
    };
  }
}

/// 检测信息
class TestInfo {
  /// 检测结果
  final String? testResult;

  /// 时间代码名称
  final String? timeCodeName;

  /// 目标状态
  final String? aimStatus;

  TestInfo({this.testResult, this.timeCodeName, this.aimStatus});

  factory TestInfo.fromJson(Map<String, dynamic> json) {
    return TestInfo(
      testResult: json['testResult'] as String?,
      timeCodeName: json['timeCodeName'] as String?,
      aimStatus: json['aimStatus'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'testResult': testResult,
      'timeCodeName': timeCodeName,
      'aimStatus': aimStatus,
    };
  }
}

/// 患者列表响应
class PatientListResponse {
  final bool success;
  final String? message;
  final List<Patient>? data;

  PatientListResponse({required this.success, this.message, this.data});

  factory PatientListResponse.fromJson(Map<String, dynamic> json) {
    return PatientListResponse(
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Patient.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}