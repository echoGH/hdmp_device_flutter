import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/patient.dart';
import '../../../providers/patient_provider.dart';
import '../../../widgets/patient_list_item.dart';

/// 患者管理页面
class PatientPage extends ConsumerStatefulWidget {
  const PatientPage({super.key});

  @override
  ConsumerState<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends ConsumerState<PatientPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

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

    // 更新provider中的当前tab
    ref.read(patientProvider.notifier).setCurrentTab(_currentIndex);
  }

  /// 加载患者数据
  Future<void> _loadPatients() async {
    final patientNotifier = ref.read(patientProvider.notifier);

    // 调用provider的loadPatients方法
    await patientNotifier.loadPatients(
      customerActiveCode: 'YOUR_CUSTOMER_CODE', // TODO 需要替换为实际的客户激活码，帮我查下安卓项目hdmp-device-app中这里激活码填的是什么
      // 可以添加搜索关键字和病区ID列表参数
    );
  }

  List<Patient> _getCurrentPatients() {
    final patientState = ref.watch(patientProvider);

    switch (_currentIndex) {
      case 0:
        return patientState.allPatients;
      case 1:
        return patientState.cgmPatients;
      case 2:
        return patientState.insulinPumpPatients;
      default:
        return patientState.allPatients;
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
    final patientState = ref.watch(patientProvider);

    if (patientState.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0073CF)),
        ),
      );
    }

    if (patientState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60.w, color: Colors.red),
            SizedBox(height: 20.h),
            Text(
              patientState.error!,
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
