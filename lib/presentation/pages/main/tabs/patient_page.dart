import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math'; // 添加随机数导入
import '../../../../core/constants/app_constants.dart';
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

  // 添加搜索相关状态
  final TextEditingController _searchController = TextEditingController();
  String? _selectedWardId;
  String? _selectedDepartment;
  bool _isSearchOpen = false;

  // 示例科室和病区数据
  final Map<String, List<String>> _departments = {
    'CCU': ['CCU1病区A', 'CCU1病区B'],
    'CCU2': [],
    '产科': ['测试病区'],
    '儿科(1)': [],
    '儿科(2)': [],
    '新生儿科': [],
  };

  // 当前选中的科室
  List<String> _getCurrentWards() {
    return _selectedDepartment != null
        ? _departments[_selectedDepartment] ?? []
        : [];
  }

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
    _searchController.dispose(); // 释放控制器资源
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
  Future<void> _loadPatients({
    String? searchKeyword,
    List<String>? wardIdList,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final savedCustomerId = prefs.getString(AppConstants.keyCustomerId);

    // 如果没有保存的客户ID，使用默认值或提示用户
    final customerActiveCode = savedCustomerId ?? 'DEFAULT_CUSTOMER_ID';

    final patientNotifier = ref.read(patientProvider.notifier);

    // 调用provider的loadPatients方法，传递搜索参数
    await patientNotifier.loadPatients(
      customerActiveCode: customerActiveCode,
      searchKeyword: searchKeyword ?? _searchController.text.trim(),
      wardIdList:
          wardIdList ?? (_selectedWardId != null ? [_selectedWardId!] : null),
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
      backgroundColor: Colors.transparent, // 设置背景透明
      body: Column(
        children: [
          // 添加指定样式的长方形
          Container(
            width: double.infinity, // 100%宽度
            height: 40.h, // 高度40
            color: const Color(0xFF0073CF), // 背景色
          ),
          // Tab导航栏和右侧操作按钮同一行
          _buildTabBarWithActions(),
          // 搜索面板
          _buildSearchPanel(),
          // 患者列表
          Expanded(child: _buildPatientContent()),
        ],
      ),
    );
  }

  /// Tab导航栏和操作按钮同一行
  Widget _buildTabBarWithActions() {
    return Container(
      height: 42.h,
      color: const Color(0xFF0073CF),
      child: Row(
        children: [
          // Tab导航栏，占据剩余空间
          Expanded(
            child: TabBar(
              controller: _tabController,
              // 自定义指示器，确保位于文字下方且不遮挡
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.white, width: 2),
                insets: EdgeInsets.symmetric(horizontal: 5.0), // 调整指示器宽度
              ),
              // 使用默认的指示器位置，避免遮挡文字
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              labelStyle: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.normal,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.normal,
              ),
              // 调整Tab之间的间隔
              labelPadding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ), // 设置Tab之间的水平间隔
              // 使用标准Tab组件
              tabs: const [
                Tab(text: '全部'),
                Tab(text: 'CGM'),
                Tab(text: '胰岛素泵'),
              ],
            ),
          ),
          // 右侧操作按钮
          Row(
            children: [
              // 根据Android实现，始终显示扫码图标
              IconButton(
                onPressed: _handleScan,
                icon: Image.asset(
                  'assets/icons/ic_pat_scan.png',
                  width: 20.w,
                  height: 20.h,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.qr_code_scanner,
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
                    return const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 20,
                    );
                  },
                ),
              ),
              SizedBox(width: 16.w),
            ],
          ),
        ],
      ),
    );
  }

  /// 患者内容区域
  Widget _buildPatientContent() {
    final patientState = ref.watch(patientProvider);

    if (patientState.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF0073CF)),
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

    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 一行两列
        childAspectRatio: 1, // 调整项目宽高比
        crossAxisSpacing: 4.w, // 列间距
        mainAxisSpacing: 4.h, // 行间距
      ),
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

  /// 处理扫码/添加按钮点击
  void _handleScan() {
    if (_currentIndex == 0) {
      // 扫码功能
      print('扫码功能');
    } else {
      // 添加患者
      print('添加患者');
    }
  }

  /// 处理搜索按钮点击
  void _handleSearch() {
    setState(() {
      _isSearchOpen = !_isSearchOpen;
      if (!_isSearchOpen) {
        // 关闭搜索时清空搜索条件
        _searchController.clear();
        _selectedWardId = null;
        _selectedDepartment = null;
        _loadPatients(); // 重新加载所有数据
      }
    });
  }

  /// 处理搜索提交
  void _handleSearchSubmit() {
    _loadPatients();
  }

  /// 处理科室选择
  void _handleDepartmentSelect(String department) {
    setState(() {
      if (_selectedDepartment == department) {
        _selectedDepartment = null;
        _selectedWardId = null;
      } else {
        _selectedDepartment = department;
        _selectedWardId = null;
      }
    });
  }

  /// 处理病区选择
  void _handleWardSelect(String ward) {
    setState(() {
      _selectedWardId = _selectedWardId == ward ? null : ward;
    });
    _loadPatients(); // 选择病区后立即搜索
  }

  /// 构建搜索面板
  Widget _buildSearchPanel() {
    if (!_isSearchOpen) return const SizedBox.shrink();

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 搜索输入框
          Container(
            padding: EdgeInsets.all(10.w),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '姓名/床号/住院号',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
              ),
              onSubmitted: (_) => _handleSearchSubmit(),
            ),
          ),

          // 科室和病区选择区域
          Container(
            height: 200.h,
            child: Row(
              children: [
                // 科室列表
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: _departments.keys.length,
                    itemBuilder: (context, index) {
                      final department = _departments.keys.elementAt(index);
                      final isSelected = _selectedDepartment == department;
                      return GestureDetector(
                        onTap: () => _handleDepartmentSelect(department),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          color: isSelected
                              ? const Color(0xFFE6F4FF)
                              : Colors.white,
                          child: Text(
                            department,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: isSelected
                                  ? const Color(0xFF0073CF)
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // 病区列表
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: _getCurrentWards().length,
                    itemBuilder: (context, index) {
                      final ward = _getCurrentWards()[index];
                      final isSelected = _selectedWardId == ward;
                      return GestureDetector(
                        onTap: () => _handleWardSelect(ward),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          color: isSelected
                              ? const Color(0xFFE6F4FF)
                              : Colors.white,
                          child: Text(
                            ward,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: isSelected
                                  ? const Color(0xFF0073CF)
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 处理患者项点击
  void _handlePatientTap(Patient patient) {
    // 导航到患者详情页面
    print('患者详情: ${patient.patientName}');
  }

  /// 处理测量按钮点击
  void _handleMeasureTap(Patient patient) {
    // 执行测量操作
    print('测量: ${patient.patientName}');
  }
}
