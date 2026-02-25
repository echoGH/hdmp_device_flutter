import '../datasources/page_info.dart';

/// 患者基本信息
class CGMPatient {
  final String id;

  /// 患者ID
  final String patientId;

  /// 访问ID
  final String? visitId;

  /// 住院流水号
  final String? inSerialId;

  final int? customerId;

  final String? isFollow;

  final String? isRemind;

  final String? deviceSn;

  final String? deviceType;

  final String? bedId;

  final String? admAge;

  final String? admDate;

  final String? cgmStatus;

  final String? cgmShowStatus;

  final String? bluetoothStatus;

  final String? hosStatus;

  final String? endTime;

  /// 患者姓名
  final String? patientName;

  final String? patientSex;

  /// 床号
  final String? bedNum;

  final int? bedPriority;

  /// 年龄
  final String? patientAge;

  /// 总测量次数
  final int? allNum;

  final List<dynamic>? testList;

  final List<dynamic>? testSegmentList;

  final List<dynamic>? testSegmentMinList;

  final String? lastTestResult;

  final String? lastTestTime;

  final String? lastTestTimeDesc;

  /// 最新血糖序列号
  final int? lastSerialNumber;

  final String? lastAimStatus;

  /// 测量趋势 1, "维持不变" (2, "缓慢下降"), (3, "快速下降"), (4, "急速下降"),(5, "缓慢上升"), (6, "快速上升"), (7, "急速上升")
  final int? testTrend;

  final String? remainderTimeDesc;

  final String? doctorInChargeName;

  final String? deptName;

  final String? wardName;

  final String? completeTime;

  final String? beginTime;

  final String? deptId;

  final String? wardId;

  final String? createTime;

  final String? initRemainderMinute;

  final List<dynamic>? cgmSegmentDetailList;

  final String? transferStatus;

  final String? bindTime;

  final int? cgmDay;

  final String? diabetesType;

  final int? increMinute;

  final String? useTime;

  final String? modelType;

  final String? tsOutHosTime;

  final String? isCheck;

  final String? patientBedCode;

  final String? patientSexDesc;

  final String? patientAgeDesc;

  final String? isInsulinPump;

  final String? isCgm;

  CGMPatient({
    required this.id,
    required this.patientId,
    this.isFollow,
    this.isRemind,
    this.deviceSn,
    this.deviceType,
    this.admAge,
    this.admDate,
    this.cgmStatus,
    this.cgmShowStatus,
    this.bluetoothStatus,
    this.hosStatus,
    this.endTime,
    this.patientSex,
    this.bedNum,
    this.bedPriority,
    this.patientAge,
    this.allNum,
    this.testList,
    this.testSegmentList,
    this.testSegmentMinList,
    this.lastTestResult,
    this.lastTestTime,
    this.patientName,
    this.inSerialId,
    this.visitId,
    this.customerId,
    this.bedId,
    this.lastTestTimeDesc,
    this.lastSerialNumber,
    this.lastAimStatus,
    this.testTrend,
    this.remainderTimeDesc,
    this.doctorInChargeName,
    this.deptName,
    this.wardName,
    this.completeTime,
    this.beginTime,
    this.deptId,
    this.wardId,
    this.createTime,
    this.initRemainderMinute,
    this.cgmSegmentDetailList,
    this.transferStatus,
    this.bindTime,
    this.cgmDay,
    this.diabetesType,
    this.increMinute,
    this.useTime,
    this.modelType,
    this.tsOutHosTime,
    this.isCheck,
    this.patientBedCode,
    this.patientSexDesc,
    this.patientAgeDesc,
    this.isInsulinPump,
    this.isCgm,
  });

  factory CGMPatient.fromJson(Map<String, dynamic> json) {
    return CGMPatient(
      id: json['id'] as String,
      patientId: json['patientId'] as String,
      isFollow: json['isFollow'] as String,
      deviceSn: json['deviceSn'] as String?,
      deviceType: json['deviceType'] as String?,
      admAge: json['admAge'] as String?,
      admDate: json['admDate'] as String?,
      cgmStatus: json['cgmStatus'] as String?,
      cgmShowStatus: json['cgmShowStatus'] as String?,
      bluetoothStatus: json['bluetoothStatus'] as String?,
      hosStatus: json['hosStatus'] as String?,
      endTime: json['endTime'] as String?,
      patientSex: json['patientSex'] as String?,
      bedNum: json['bedNum'] as String?,
      bedPriority: json['bedPriority'] as int?,
      patientAge: json['patientAge'] as String?,
      allNum: json['allNum'] as int?,
      testList: json['testList'] != null ? json['testList'] as List<dynamic> : [],
      testSegmentList: json['testSegmentList'] != null ? json['testSegmentList'] as List<dynamic> : [],
      testSegmentMinList: json['testSegmentMinList'] != null ? json['testSegmentMinList'] as List<dynamic> : [],
      lastTestResult: json['lastTestResult'] as String?,
      lastTestTime: json['lastTestTime'] as String?,
      patientName: json['patientName'] as String?,
      inSerialId: json['inSerialId'] as String?,
      visitId: json['visitId'] as String?,
      customerId: json['customerId'] as int?,
      bedId: json['bedId'] as String?,
      lastTestTimeDesc: json['lastTestTimeDesc'] as String?,
      lastSerialNumber: json['lastSerialNumber'] as int?,
      lastAimStatus: json['lastAimStatus'] as String?,
      testTrend: json['testTrend'] as int?,
      remainderTimeDesc: json['remainderTimeDesc'] as String?,
      doctorInChargeName: json['doctorInChargeName'] as String?,
      deptName: json['deptName'] as String?,
      wardName: json['wardName'] as String?,
      completeTime: json['completeTime'] as String?,
      beginTime: json['beginTime'] as String?,
      deptId: json['deptId'] as String?,
      wardId: json['wardId'] as String?,
      createTime: json['createTime'] as String?,
      initRemainderMinute: json['initRemainderMinute'] as String?,
      cgmSegmentDetailList: json['cgmSegmentDetailList'] != null ? json['cgmSegmentDetailList'] as List<int> : [],
      transferStatus: json['transferStatus'] as String?,
      bindTime: json['bindTime'] as String?,
      cgmDay: json['cgmDay'] as int?,
      diabetesType: json['diabetesType'] as String?,
      increMinute: json['increMinute'] as int?,
      useTime: json['useTime'] as String?,
      modelType: json['modelType'] as String?,
      tsOutHosTime: json['tsOutHosTime'] as String?,
      isCheck: json['isCheck'] as String?,
      patientBedCode: json['patientBedCode'] as String?,
      patientSexDesc: json['patientSexDesc'] as String?,
      patientAgeDesc: json['patientAgeDesc'] as String?,
      isInsulinPump: json['isInsulinPump'] as String?,
      isCgm: json['isCgm'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'isFollow': isFollow,
      'deviceSn': deviceSn,
      'deviceType': deviceType,
      'admAge': admAge,
      'admDate': admDate,
      'cgmStatus': cgmStatus,
      'cgmShowStatus': cgmShowStatus,
      'bluetoothStatus': bluetoothStatus,
      'hosStatus': hosStatus,
      'endTime': endTime,
      'patientSex': patientSex,
      'bedNum': bedNum,
      'bedPriority': bedPriority,
      'patientAge': patientAge,
      'allNum': allNum,
      'testList': testList,
      'testSegmentList': testSegmentList,
      'testSegmentMinList': testSegmentMinList,
      'lastTestResult': lastTestResult,
      'lastTestTime': lastTestTime,
      'patientName': patientName,
      'inSerialId': inSerialId,
      'visitId': visitId,
      'customerId': customerId,
      'bedId': bedId,
      'lastTestTimeDesc': lastTestTimeDesc,
      'lastSerialNumber': lastSerialNumber,
      'lastAimStatus': lastAimStatus,
      'testTrend': testTrend,
      'remainderTimeDesc': remainderTimeDesc,
      'doctorInChargeName': doctorInChargeName,
      'deptName': deptName,
      'wardName': wardName,
      'completeTime': completeTime,
      'beginTime': beginTime,
      'deptId': deptId,
      'wardId': wardId,
      'createTime': createTime,
      'initRemainderMinute': initRemainderMinute,
      'cgmSegmentDetailList': cgmSegmentDetailList,
      'transferStatus': transferStatus,
      'bindTime': bindTime,
      'cgmDay': cgmDay,
      'diabetesType': diabetesType,
      'increMinute': increMinute,
      'useTime': useTime,
      'modelType': modelType,
      'tsOutHosTime': tsOutHosTime,
      'isCheck': isCheck,
      'patientBedCode': patientBedCode,
      'patientSexDesc': patientSexDesc,
      'patientAgeDesc': patientAgeDesc,
      'isInsulinPump': isInsulinPump,
      'isCgm': isCgm,
    };
  }
}

/// CGM患者列表响应
class CGMPatientPageList extends PageInfo {
  final List<CGMPatient>? list;

  CGMPatientPageList({super.totalCount, super.pageSize, super.totalPage, super.currPage, this.list});

  factory CGMPatientPageList.fromJson(Map<String, dynamic> json) {
    return CGMPatientPageList(
      totalCount: json['totalCount'] as int?,
      pageSize: json['pageSize'] as int?,
      totalPage: json['totalPage'] as int?,
      currPage: json['currPage'] as int?,
      list: (json['list'] as List<dynamic>?)?.map((e) => CGMPatient.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
