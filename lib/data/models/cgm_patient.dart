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

  final String? low;

  final String? high;

  final String? deviceSn;

  final String? deviceType;

  final String? bedId;

  final String? admAge;

  final String? admDate;

  final String? cgmStatus;

  final String? cgmShowStatus;

  final String? hosStatus;

  final String? hosLeaveTime;

  final String? endTime;

  /// 患者姓名
  final String? patientName;

  final String? patientSex;

  /// 床号
  final String? bedNum;

  final int? bedPriority;

  /// 年龄
  final String? patientAge;

  final String? allNum;

  final List<String>? testList;

  final List<String>? testSegmentList;

  final List<String>? testSegmentMinList;

  final String? lastTestResult;

  final String? lastTestTime;

  final String? lastTestTimeDesc;

  final String? lastSerialNumber;

  final String? lastAimStatus;

  final String? firstTestResult;

  final String? firstTestTime;

  final String? firstAimStatus;

  final String? testTrend;

  final String? remainderTimeDesc;

  final String? remainderTimeDay;

  final String? remainderTimeHour;

  final String? remainderTimeMinute;

  final String? doctorInChargeName;

  final String? deptName;

  final String? wardName;

  final String? gmiPer;

  final String? tirPer;

  final String? tarPer;

  final String? tbrPer;

  final String? completeTime;

  final String? beginTime;

  final String? deptId;

  final String? wardId;

  final String? createTime;

  final String? initRemainderMinute;

  final List<String>? cgmSegmentDetailList;

  final String? transferStatus;

  final String? bindTime;

  final String? realReminderTime;

  final bool? qrCodeButton;

  final bool? transferButton;

  final bool? retryButton;

  final String? commonMinValue;

  final String? commonMaxValue;

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

  final String? bgmTests;

  final String? errorMsg;

  final String? errorMsgJson;

  final String? printStatus;

  final bool? isFeedBack;

  CGMPatient({
    required this.id,
    required this.patientId,
    this.isFollow,
    this.isRemind,
    this.low,
    this.high,
    this.deviceSn,
    this.deviceType,
    this.admAge,
    this.admDate,
    this.cgmStatus,
    this.cgmShowStatus,
    this.hosStatus,
    this.hosLeaveTime,
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
    this.firstTestResult,
    this.firstTestTime,
    this.firstAimStatus,
    this.testTrend,
    this.remainderTimeDesc,
    this.remainderTimeDay,
    this.remainderTimeHour,
    this.remainderTimeMinute,
    this.doctorInChargeName,
    this.deptName,
    this.wardName,
    this.gmiPer,
    this.tirPer,
    this.tarPer,
    this.tbrPer,
    this.completeTime,
    this.beginTime,
    this.deptId,
    this.wardId,
    this.createTime,
    this.initRemainderMinute,
    this.cgmSegmentDetailList,
    this.transferStatus,
    this.bindTime,
    this.realReminderTime,
    this.qrCodeButton,
    this.transferButton,
    this.retryButton,
    this.commonMinValue,
    this.commonMaxValue,
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
    this.bgmTests,
    this.errorMsg,
    this.errorMsgJson,
    this.printStatus,
    this.isFeedBack,
  });

  factory CGMPatient.fromJson(Map<String, dynamic> json) {
    return CGMPatient(
      id: json['id'] as String,
      patientId: json['patientId'] as String,
      isFollow: json['isFollow'] as String,
      low: json['low'] as String,
      high: json['high'] as String?,
      deviceSn: json['deviceSn'] as String?,
      deviceType: json['deviceType'] as String?,
      admAge: json['admAge'] as String?,
      admDate: json['admDate'] as String?,
      cgmStatus: json['cgmStatus'] as String?,
      cgmShowStatus: json['cgmShowStatus'] as String?,
      hosStatus: json['hosStatus'] as String?,
      hosLeaveTime: json['hosLeaveTime'] as String?,
      endTime: json['endTime'] as String?,
      patientSex: json['patientSex'] as String?,
      bedNum: json['bedNum'] as String?,
      bedPriority: json['bedPriority'] as int?,
      patientAge: json['patientAge'] as String?,
      allNum: json['allNum'] as String?,
      testList: json['testList'] != null ? json['testList'] as List<String> : [],
      testSegmentList: json['testSegmentList'] != null ? json['testSegmentList'] as List<String> : [],
      testSegmentMinList: json['testSegmentMinList'] != null ? json['testSegmentMinList'] as List<String> : [],
      lastTestResult: json['lastTestResult'] as String?,
      lastTestTime: json['lastTestTime'] as String?,
      patientName: json['patientName'] as String?,
      inSerialId: json['inSerialId'] as String?,
      visitId: json['visitId'] as String?,
      customerId: json['customerId'] as int?,
      bedId: json['bedId'] as String?,
      this.lastTestTimeDesc,
      this.lastSerialNumber,
      this.lastAimStatus,
      this.firstTestResult,
      this.firstTestTime,
      this.firstAimStatus,
      this.testTrend,
      this.remainderTimeDesc,
      this.remainderTimeDay,
      this.remainderTimeHour,
      this.remainderTimeMinute,
      this.doctorInChargeName,
      this.deptName,
      this.wardName,
      this.gmiPer,
      this.tirPer,
      this.tarPer,
      this.tbrPer,
      this.completeTime,
      this.beginTime,
      this.deptId,
      this.wardId,
      this.createTime,
      this.initRemainderMinute,
      this.cgmSegmentDetailList,
      this.transferStatus,
      this.bindTime,
      this.realReminderTime,
      this.qrCodeButton,
      this.transferButton,
      this.retryButton,
      this.commonMinValue,
      this.commonMaxValue,
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
      this.bgmTests,
      this.errorMsg,
      this.errorMsgJson,
      this.printStatus,
      this.isFeedBack,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'isFollow': isFollow,
      'low': low,
      'high': high,
      'deviceSn': deviceSn,
      'deviceType': deviceType,
      'admAge': admAge,
      'admDate': admDate,
      'cgmStatus': cgmStatus,
      'cgmShowStatus': cgmShowStatus,
      'hosStatus': hosStatus,
      'hosLeaveTime': hosLeaveTime,
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
      this.lastTestTimeDesc,
      this.lastSerialNumber,
      this.lastAimStatus,
      this.firstTestResult,
      this.firstTestTime,
      this.firstAimStatus,
      this.testTrend,
      this.remainderTimeDesc,
      this.remainderTimeDay,
      this.remainderTimeHour,
      this.remainderTimeMinute,
      this.doctorInChargeName,
      this.deptName,
      this.wardName,
      this.gmiPer,
      this.tirPer,
      this.tarPer,
      this.tbrPer,
      this.completeTime,
      this.beginTime,
      this.deptId,
      this.wardId,
      this.createTime,
      this.initRemainderMinute,
      this.cgmSegmentDetailList,
      this.transferStatus,
      this.bindTime,
      this.realReminderTime,
      this.qrCodeButton,
      this.transferButton,
      this.retryButton,
      this.commonMinValue,
      this.commonMaxValue,
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
      this.bgmTests,
      this.errorMsg,
      this.errorMsgJson,
      this.printStatus,
      this.isFeedBack,
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
