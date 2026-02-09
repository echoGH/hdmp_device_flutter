import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../../core/network/dio_client.dart';
import '../../core/models/patient.dart';
import '../../data/remote/api/patient_service.dart';
import '../../data/remote/entity/request/query_patient_request.dart';

/// 患者状态
class PatientStateModel {
  final List<Patient> allPatients;
  final List<Patient> cgmPatients;
  final List<Patient> insulinPumpPatients;
  final bool isLoading;
  final String? error;
  final int currentTab;

  const PatientStateModel({required this.allPatients, required this.cgmPatients, required this.insulinPumpPatients, required this.isLoading, this.error, required this.currentTab});

  PatientStateModel copyWith({List<Patient>? allPatients, List<Patient>? cgmPatients, List<Patient>? insulinPumpPatients, bool? isLoading, String? error, int? currentTab}) {
    return PatientStateModel(
      allPatients: allPatients ?? this.allPatients,
      cgmPatients: cgmPatients ?? this.cgmPatients,
      insulinPumpPatients: insulinPumpPatients ?? this.insulinPumpPatients,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      currentTab: currentTab ?? this.currentTab,
    );
  }

  List<Patient> getCurrentPatients() {
    switch (currentTab) {
      case 0:
        return allPatients;
      case 1:
        return cgmPatients;
      case 2:
        return insulinPumpPatients;
      default:
        return allPatients;
    }
  }
}

/// 患者Provider
class PatientNotifier extends Notifier<PatientStateModel> {
  late PatientService _patientService;

  @override
  PatientStateModel build() {
    _patientService = PatientService(DioClient.instance.dio);
    return const PatientStateModel(allPatients: [], cgmPatients: [], insulinPumpPatients: [], isLoading: false, error: null, currentTab: 0);
  }

  /// 获取患者列表
  Future<void> loadPatients({required String customerActiveCode, String? searchKeyword, List<String>? wardIdList}) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      // 并行获取三个列表
      final results = await Future.wait([
        _patientService.getPatientList(QueryPatientRequest(customerActiveCode: customerActiveCode, searchKeyword: searchKeyword, wardIdList: wardIdList)),
        // _patientService.getCgmPatientList(
        //   QueryPatientRequest(
        //     customerActiveCode: customerActiveCode,
        //     searchKeyword: searchKeyword,
        //     wardIdList: wardIdList,
        //   ),
        // ),
        // _patientService.getInsulinPumpPatientList(
        //   QueryPatientRequest(
        //     customerActiveCode: customerActiveCode,
        //     searchKeyword: searchKeyword,
        //     wardIdList: wardIdList,
        //   ),
        // ),
      ]);

      state = state.copyWith(
        isLoading: false,
        allPatients: results[0].data?.list ?? [],
        cgmPatients: [], // results[1].data?.list ?? [],
        insulinPumpPatients: [], // results[2].data?.list ?? [],
      );
    } catch (e) {
      debugPrint('加载患者列表失败: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// 切换Tab
  void setCurrentTab(int tabIndex) {
    state = state.copyWith(currentTab: tabIndex);
  }

  /// 刷新数据
  Future<void> refresh({required String customerActiveCode, String? searchKeyword, List<String>? wardIdList}) async {
    await loadPatients(customerActiveCode: customerActiveCode, searchKeyword: searchKeyword, wardIdList: wardIdList);
  }
}

/// 患者Provider实例
final patientProvider = NotifierProvider<PatientNotifier, PatientStateModel>(() {
  return PatientNotifier();
});
