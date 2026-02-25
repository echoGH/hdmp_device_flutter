import '../datasources/page_info.dart';

/// 患者基本信息
class Patient {
  final String id;

  /// 患者ID
  final String patientId;

  /// 访问ID
  final String? visitId;

  /// 住院流水号
  final String? inSerialId;

  final int? customerId;

  final String? wardId;

  final String? deptId;

  final String? bedId;

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

  /// 诊断信息
  final String? diagnosis;

  /// 是否CGM患者 (1:是, 0:否)
  final String? isCgm;

  /// 是否胰岛素泵患者 (1:是, 0:否)
  final String? isInsulinPump;

  /// 血糖任务数
  final String? bgmPlanNum;

  /// 已执行血糖任务数
  final String? bgmPlanFinishNum;

  /// 最新血糖记录
  final TestInfo? testInfo;

  Patient({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.bedCode,
    this.inSerialId,
    this.visitId,
    this.customerId,
    this.wardId,
    this.deptId,
    this.bedId,
    this.sexDesc,
    this.ageDesc,
    this.deptName,
    this.wardName,
    this.diagnosis,
    this.isCgm,
    this.isInsulinPump,
    this.bgmPlanNum,
    this.bgmPlanFinishNum,
    this.testInfo,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as String,
      patientId: json['patientId'] as String,
      patientName: json['patientName'] as String,
      bedCode: json['bedCode'] as String,
      inSerialId: json['inSerialId'] as String?,
      visitId: json['visitId'] as String?,
      customerId: json['customerId'] as int?,
      wardId: json['wardId'] as String?,
      deptId: json['deptId'] as String?,
      bedId: json['bedId'] as String?,
      sexDesc: json['sexDesc'] as String?,
      ageDesc: json['ageDesc'] as String?,
      deptName: json['deptName'] as String?,
      wardName: json['wardName'] as String?,
      diagnosis: json['diagnosis'] as String?,
      isCgm: json['isCgm'] as String?,
      isInsulinPump: json['isInsulinPump'] as String?,
      bgmPlanNum: json['bgmPlanNum'] as String?,
      bgmPlanFinishNum: json['bgmPlanFinishNum'] as String?,
      testInfo: json['testInfo'] != null ? TestInfo.fromJson(json['testInfo'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'visitId': visitId,
      'inSerialId': inSerialId,
      'customerId': customerId,
      'wardId': wardId,
      'deptId': deptId,
      'bedId': bedId,
      'patientName': patientName,
      'bedCode': bedCode,
      'sexDesc': sexDesc,
      'ageDesc': ageDesc,
      'deptName': deptName,
      'wardName': wardName,
      'diagnosis': diagnosis,
      'isCgm': isCgm,
      'isInsulinPump': isInsulinPump,
      'bgmPlanNum': bgmPlanNum,
      'bgmPlanFinishNum': bgmPlanFinishNum,
      'testInfo': testInfo?.toJson(),
    };
  }
}

/// 检测信息
class TestInfo {
  /// 检测时间
  final String? testTime;

  /// 检测结果
  final String? testResult;

  /// 时间代码名称
  final String? timeCodeName;

  /// 目标状态
  final String? aimStatus;

  /// 是否脱机检测 (1:是, 2:否)
  final String? isOffTest;

  TestInfo({this.testTime, this.testResult, this.timeCodeName, this.aimStatus, this.isOffTest});

  factory TestInfo.fromJson(Map<String, dynamic> json) {
    return TestInfo(
      testTime: json['testTime'] as String?,
      testResult: json['testResult'] as String?,
      timeCodeName: json['timeCodeName'] as String?,
      aimStatus: json['aimStatus'] as String?,
      isOffTest: json['isOffTest'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'testTime': testTime, 'testResult': testResult, 'timeCodeName': timeCodeName, 'aimStatus': aimStatus, 'isOffTest': isOffTest};
  }
}

/// 患者列表响应
class PatientPageList extends PageInfo {
  final List<Patient>? list;

  PatientPageList({super.totalCount, super.pageSize, super.totalPage, super.currPage, this.list});

  factory PatientPageList.fromJson(Map<String, dynamic> json) {
    return PatientPageList(
      totalCount: json['totalCount'] as int?,
      pageSize: json['pageSize'] as int?,
      totalPage: json['totalPage'] as int?,
      currPage: json['currPage'] as int?,
      list: (json['list'] as List<dynamic>?)?.map((e) => Patient.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
