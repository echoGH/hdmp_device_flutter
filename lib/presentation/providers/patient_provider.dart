import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/models/patient.dart';
import '../../core/network/dio_client.dart';
import '../../data/remote/api/patient_service.dart';
import '../../data/remote/entity/request/query_patient_request.dart';

/// 患者状态管理
@riverpod
class PatientState {
  final List<Patient> allPatients;
  final List<Patient> cgmPatients;
  final List<Patient> insulinPumpPatients;
  final bool isLoading;
  final String? error;
  final int currentTab;

  const PatientState({required this.allPatients, required this.cgmPatients, required this.insulinPumpPatients, required this.isLoading, this.error, required this.currentTab});

  PatientState copyWith({List<Patient>? allPatients, List<Patient>? cgmPatients, List<Patient>? insulinPumpPatients, bool? isLoading, String? error, int? currentTab}) {
    return PatientState(
      allPatients: allPatients ?? this.allPatients,
      cgmPatients: cgmPatients ?? this.cgmPatients,
      insulinPumpPatients: insulinPumpPatients ?? this.insulinPumpPatients,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
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
class PatientNotifier extends Notifier<PatientState> {
  late PatientService _patientService;

  @override
  PatientState build() {
    _patientService = PatientService(DioClient.instance.dio);
    return const PatientState(allPatients: [], cgmPatients: [], insulinPumpPatients: [], isLoading: false, currentTab: 0);
  }

  /// 并行获取三个列表
  Future<void> getPatients({
    required String customerActiveCode,
    String? searchKeyword,
    List<String>? wardIdList,
  }) async {
    try {
      final results = await Future.wait([
        _patientService.getPatientList(QueryPatientRequest(customerActiveCode: customerActiveCode, searchKeyword: searchKeyword, wardIdList: wardIdList, page: 1, pageSize: 10)),
        _patientService.getCgmPatientList(QueryPatientRequest(customerActiveCode: customerActiveCode, searchKeyword: searchKeyword, wardIdList: wardIdList, page: 1, pageSize: 10)),
        _patientService.getInsulinPumpPatientList(QueryPatientRequest(customerActiveCode: customerActiveCode, searchKeyword: searchKeyword, wardIdList: wardIdList, page: 1, pageSize: 10)),
      ]);

      state = state.copyWith(isLoading: false, allPatients: results[0].data ?? [], cgmPatients: results[1].data ?? [], insulinPumpPatients: results[2].data ?? []);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: '获取患者列表异常: $e');
    }
  }

  /// 切换Tab
  void setCurrentTab(int tabIndex) {
    state = state.copyWith(currentTab: tabIndex);
  }

  /// 刷新数据
  Future<void> refresh({
    required String customerActiveCode,
    String? searchKeyword,
    List<String>? wardIdList,
  }) async {
    await getPatients(
      customerActiveCode: customerActiveCode,
      searchKeyword: searchKeyword,
      wardIdList: wardIdList,
    );
  }
}

/// 患者Provider实例
final patientProvider = NotifierProvider<PatientNotifier, PatientState>(() {
  return PatientNotifier();
});
