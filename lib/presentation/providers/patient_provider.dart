import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../../core/models/patient.dart';
import '../../data/services/patient_service.dart';

part 'patient_provider.g.dart';

/// 患者状态管理
@riverpod
class PatientState extends _$PatientState {
  @override
  PatientStateModel build() {
    return PatientStateModel(
      allPatients: [],
      cgmPatients: [],
      insulinPumpPatients: [],
      isLoading: false,
      error: null,
      currentTab: 0,
    );
  }

  /// 获取患者列表
  Future<void> loadPatients({
    required String customerActiveCode,
    String? searchKeyword,
    List<String>? wardIdList,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final dio = Dio();
      dio.options.baseUrl = 'http://192.168.187.18:7009';
      dio.options.connectTimeout = const Duration(seconds: 10);
      dio.options.receiveTimeout = const Duration(seconds: 10);
      
      final service = PatientService(dio);

      // 并行获取三个列表
      final results = await Future.wait([
        service.getPatientList(
          PatientRequest(
            customerActiveCode: customerActiveCode,
            searchKeyword: searchKeyword,
            wardIdList: wardIdList,
          ),
        ),
        service.getCgmPatientList(
          PatientRequest(
            customerActiveCode: customerActiveCode,
            searchKeyword: searchKeyword,
            wardIdList: wardIdList,
          ),
        ),
        service.getInsulinPumpPatientList(
          PatientRequest(
            customerActiveCode: customerActiveCode,
            searchKeyword: searchKeyword,
            wardIdList: wardIdList,
          ),
        ),
      ]);

      state = state.copyWith(
        isLoading: false,
        allPatients: results[0].data ?? [],
        cgmPatients: results[1].data ?? [],
        insulinPumpPatients: results[2].data ?? [],
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
  Future<void> refresh({
    required String customerActiveCode,
    String? searchKeyword,
    List<String>? wardIdList,
  }) async {
    await loadPatients(
      customerActiveCode: customerActiveCode,
      searchKeyword: searchKeyword,
      wardIdList: wardIdList,
    );
  }
}

/// 患者状态模型
class PatientStateModel {
  final List<Patient> allPatients;
  final List<Patient> cgmPatients;
  final List<Patient> insulinPumpPatients;
  final bool isLoading;
  final String? error;
  final int currentTab;

  PatientStateModel({
    required this.allPatients,
    required this.cgmPatients,
    required this.insulinPumpPatients,
    required this.isLoading,
    this.error,
    required this.currentTab,
  });

  PatientStateModel copyWith({
    List<Patient>? allPatients,
    List<Patient>? cgmPatients,
    List<Patient>? insulinPumpPatients,
    bool? isLoading,
    String? error,
    int? currentTab,
  }) {
    return PatientStateModel(
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