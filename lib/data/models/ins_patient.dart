import '../datasources/page_info.dart';

/// 患者基本信息
class InsPatient {
  final String id;

  /// 患者ID
  final String? patientId;

  /// 访问ID
  final String? visitId;

  /// 住院流水号
  final String? inSerialId;

  final int? customerId;

  final String? wardId;

  final String? deptId;

  final String? bedId;

  /// 患者姓名
  final String? patientName;

  /// 床号
  final String? bedCode;

  /// 性别描述
  final String? sexDesc;

  /// 年龄描述
  final String? ageDesc;

  /// 科室名称
  final String? deptName;

  /// 病区名称
  final String? wardName;

  final String? useDay;

  final String? useDayDesc;

  final String? upPumpTime;

  final String? sexSv;

  final String? sex;

  final String? age;

  final String? currentBasal;

  final String? currentBolus;

  final String? currentBolusTime;

  final bool? onlyShowRecord;

  final String? alarmCode;

  final String? alarmTitle;

  final String? alarmDesc;

  final String? companyDict;

  final String? companyDictDesc;

  final String? serialNumber;

  final String? insulinPumpId;

  final String? status;

  final List<BasalInfo>? basalList;

  final List<BolusInfo>? bolusList;

  final String? pumpLastUpdateTime;

  InsPatient({
    required this.id,
    this.patientId,
    this.visitId,
    this.inSerialId,
    this.customerId,
    this.wardId,
    this.deptId,
    this.bedId,
    this.patientName,
    this.bedCode,
    this.sexDesc,
    this.ageDesc,
    this.deptName,
    this.wardName,
    this.useDay,
    this.useDayDesc,
    this.upPumpTime,
    this.sexSv,
    this.sex,
    this.age,
    this.currentBasal,
    this.currentBolus,
    this.currentBolusTime,
    this.onlyShowRecord,
    this.alarmCode,
    this.alarmTitle,
    this.alarmDesc,
    this.companyDict,
    this.companyDictDesc,
    this.serialNumber,
    this.insulinPumpId,
    this.status,
    this.basalList,
    this.bolusList,
    this.pumpLastUpdateTime,
  });

  factory InsPatient.fromJson(Map<String, dynamic> json) {
    return InsPatient(
      id: json['id'] as String,
      patientId: json['patientId'] as String?,
      patientName: json['patientName'] as String?,
      bedCode: json['bedCode'] as String?,
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
      useDay: json['useDay'] as String?,
      useDayDesc: json['useDayDesc'] as String?,
      upPumpTime: json['upPumpTime'] as String?,
      sexSv: json['sexSv'] as String?,
      sex: json['sex'] as String?,
      age: json['age'] as String?,
      currentBasal: json['currentBasal'] as String?,
      currentBolus: json['currentBolus'] as String?,
      currentBolusTime: json['currentBolusTime'] as String?,
      onlyShowRecord: json['onlyShowRecord'] as bool?,
      alarmCode: json['alarmCode'] as String?,
      alarmTitle: json['alarmTitle'] as String?,
      alarmDesc: json['alarmDesc'] as String?,
      companyDict: json['companyDict'] as String?,
      companyDictDesc: json['companyDictDesc'] as String?,
      serialNumber: json['serialNumber'] as String?,
      insulinPumpId: json['insulinPumpId'] as String?,
      status: json['status'] as String?,
      basalList: (json['basalList'] as List<dynamic>?)?.map((e) => BasalInfo.fromJson(e as Map<String, dynamic>)).toList(),
      bolusList: (json['bolusList'] as List<dynamic>?)?.map((e) => BolusInfo.fromJson(e as Map<String, dynamic>)).toList(),
      pumpLastUpdateTime: json['pumpLastUpdateTime'] as String?,
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
      'useDay': useDay,
      'useDayDesc': useDayDesc,
      'upPumpTime': upPumpTime,
      'sexSv': sexSv,
      'sex': sex,
      'age': age,
      'currentBasal': currentBasal,
      'currentBolus': currentBolus,
      'currentBolusTime': currentBolusTime,
      'onlyShowRecord': onlyShowRecord,
      'alarmCode': alarmCode,
      'alarmTitle': alarmTitle,
      'alarmDesc': alarmDesc,
      'companyDict': companyDict,
      'companyDictDesc': companyDictDesc,
      'serialNumber': serialNumber,
      'insulinPumpId': insulinPumpId,
      'status': status,
      'basalList': basalList,
      'bolusList': bolusList,
      'pumpLastUpdateTime': pumpLastUpdateTime,
    };
  }
}

class BasalInfo {
  final String? doseTime;

  final int? dose;

  BasalInfo({this.doseTime, this.dose});

  factory BasalInfo.fromJson(Map<String, dynamic> json) {
    return BasalInfo(doseTime: json['doseTime'] as String?, dose: json['dose'] as int?);
  }

  Map<String, dynamic> toJson() {
    return {'doseTime': doseTime, 'dose': dose};
  }
}

class BolusInfo {
  final String? doseTime;

  final int? dose;

  BolusInfo({this.doseTime, this.dose});

  factory BolusInfo.fromJson(Map<String, dynamic> json) {
    return BolusInfo(doseTime: json['doseTime'] as String?, dose: json['dose'] as int?);
  }

  Map<String, dynamic> toJson() {
    return {'doseTime': doseTime, 'dose': dose};
  }
}

/// 胰岛素泵患者列表响应
class InsPatientPageList extends PageInfo {
  final List<InsPatient>? list;

  InsPatientPageList({super.totalCount, super.pageSize, super.totalPage, super.currPage, this.list});

  factory InsPatientPageList.fromJson(Map<String, dynamic> json) {
    return InsPatientPageList(
      totalCount: json['totalCount'] as int?,
      pageSize: json['pageSize'] as int?,
      totalPage: json['totalPage'] as int?,
      currPage: json['currPage'] as int?,
      list: (json['list'] as List<dynamic>?)?.map((e) => InsPatient.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
