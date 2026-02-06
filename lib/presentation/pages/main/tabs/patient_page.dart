import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import '../../../../core/models/patient.dart';
import '../../../widgets/patient_list_item.dart';

/// 患者管理页面
class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
  bool _isLoading = false;
  String? _error;

  // 患者数据
  List<Patient> _allPatients = [];
  List<Patient> _cgmPatients = [];
  List<Patient> _insulinPumpPatients = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);

    // 初始化加载数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadPatients();
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) return;
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  /// 加载患者数据
  Future<void> _loadPatients() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final dio = Dio();
      dio.options.baseUrl = 'http://192.168.187.18:7009';
      dio.options.connectTimeout = const Duration(seconds: 10);
      dio.options.receiveTimeout = const Duration(seconds: 10);

      // 使用模拟数据
      final mockPatients = [
        Patient(
          patientId: '1',
          inSerialId: '001',
          patientName: '李毅明',
          bedCode: '03',
          sexDesc: '男',
          ageDesc: '33岁',
          deptName: '内分泌科',
          wardName: '一病区',
          isCgm: '1',
          isInsulinPump: '0',
          bgmPlanNum: '5',
          bgmPlanFinishNum: '1',
          admDate: '2024-01-01',
          visitId: '2020200',
          testInfo: TestInfo(
            testResult: '6.2',
            timeCodeName: '早餐前',
            aimStatus: 'normal',
          ),
        ),
        Patient(
          patientId: '2',
          inSerialId: '002',
          patientName: '张小红',
          bedCode: '05',
          sexDesc: '女',
          ageDesc: '28岁',
          deptName: '内分泌科',
          wardName: '一病区',
          isCgm: '0',
          isInsulinPump: '1',
          bgmPlanNum: '3',
          bgmPlanFinishNum: '2',
          admDate: '2024-01-02',
          visitId: '2020201',
          testInfo: TestInfo(
            testResult: '8.5',
            timeCodeName: '午餐后',
            aimStatus: 'high',
          ),
        ),
      ];

      setState(() {
        _isLoading = false;
        _allPatients = mockPatients;
        _cgmPatients = mockPatients.where((p) => p.isCgm == '1').toList();
        _insulinPumpPatients = mockPatients
            .where((p) => p.isInsulinPump == '1')
            .toList();
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  List<Patient> _getCurrentPatients() {
    switch (_currentIndex) {
      case 0:
        return _allPatients;
      case 1:
        return _cgmPatients;
      case 2:
        return _insulinPumpPatients;
      default:
        return _allPatients;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F5), // 匹配Android背景色
      body: Column(
        children: [
          // 顶部科室病区选择区域（简化版）
          _buildDepartmentSection(),

          // Tab导航栏
          _buildTabBar(),

          // 右侧操作按钮
          _buildActionButtons(),

          // 患者列表
          Expanded(child: _buildPatientContent()),
        ],
      ),
    );
  }

  /// 科室病区选择区域
  Widget _buildDepartmentSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      color: Colors.white,
      child: Column(
        children: [
          // 科室选择
          Padding(
            padding: EdgeInsets.only(left: 20.w, bottom: 6.h),
            child: Row(
              children: [
                Text(
                  '科室',
                  style: TextStyle(fontSize: 15.sp, color: Colors.black87),
                ),
                SizedBox(width: 20.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Text('内分泌科', style: TextStyle(fontSize: 15.sp)),
                ),
              ],
            ),
          ),

          // 病区选择和查询按钮
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Row(
              children: [
                Text(
                  '病区',
                  style: TextStyle(fontSize: 15.sp, color: Colors.black87),
                ),
                SizedBox(width: 20.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Text('一病区', style: TextStyle(fontSize: 15.sp)),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // TODO: 实现查询功能
                    _loadPatients(); // 临时用刷新代替查询
                  },
                  child: Text(
                    '查询',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: const Color(0xFF0073CF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Tab导航栏
  Widget _buildTabBar() {
    return Container(
      height: 42.h,
      color: const Color(0xFF0073CF),
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        indicatorWeight: 2.h,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        labelStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.normal),
        unselectedLabelStyle: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.normal,
        ),
        tabs: const [
          Tab(text: '全部'),
          Tab(text: 'CGM'),
          Tab(text: '胰岛素泵'),
        ],
      ),
    );
  }

  /// 右侧操作按钮
  Widget _buildActionButtons() {
    return Container(
      height: 42.h,
      color: const Color(0xFF0073CF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: _handleScan,
            icon: Image.asset(
              _currentIndex == 0
                  ? 'assets/icons/ic_pat_scan.png'
                  : 'assets/icons/ic_pat_add.png',
              width: 20.w,
              height: 20.h,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  _currentIndex == 0 ? Icons.qr_code_scanner : Icons.add,
                  color: Colors.white,
                  size: 20.w,
                );
              },
            ),
          ),
          IconButton(
            onPressed: _handleSearch,
            icon: Image.asset(
              'assets/icons/ic_pat_search.png',
              width: 20.w,
              height: 20.h,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.search, color: Colors.white, size: 20);
              },
            ),
          ),
          SizedBox(width: 16.w),
        ],
      ),
    );
  }

  /// 患者内容区域
  Widget _buildPatientContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0073CF)),
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60.w, color: Colors.red),
            SizedBox(height: 20.h),
            Text(
              _error!,
              style: TextStyle(fontSize: 16.sp, color: Colors.red),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            ElevatedButton(onPressed: _loadPatients, child: const Text('重新加载')),
          ],
        ),
      );
    }

    final patients = _getCurrentPatients();

    if (patients.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 60.w, color: Colors.grey),
            SizedBox(height: 20.h),
            Text(
              '暂无患者数据',
              style: TextStyle(fontSize: 16.sp, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      itemCount: patients.length,
      itemBuilder: (context, index) {
        final patient = patients[index];
        return PatientListItem(
          patient: patient,
          onTap: () => _handlePatientTap(patient),
          onMeasureTap: () => _handleMeasureTap(patient),
        );
      },
    );
  }

  void _handleScan() {
    // TODO: 实现扫描功能
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('扫描功能待实现')));
  }

  void _handleSearch() {
    // TODO: 实现搜索功能
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('搜索功能待实现')));
  }

  void _handlePatientTap(Patient patient) {
    // TODO: 跳转到患者详情页面
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('查看患者: ${patient.patientName}')));
  }

  void _handleMeasureTap(Patient patient) {
    // TODO: 跳转到测量页面
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('为患者 ${patient.patientName} 进行测量')));
  }
}
