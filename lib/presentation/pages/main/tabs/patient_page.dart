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

class _PatientPageState extends ConsumerState<PatientPage> with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  // 添加搜索相关状态
  final TextEditingController _searchController = TextEditingController();
  String? _selectedWardId;
  List<String> _wardIds = ['WARD_001', 'WARD_002', 'WARD_003']; // 示例病区ID

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
  Future<void> _loadPatients({String? searchKeyword, List<String>? wardIdList}) async {
    final prefs = await SharedPreferences.getInstance();
    final savedCustomerId = prefs.getString(AppConstants.keyCustomerId);

    // 如果没有保存的客户ID，使用默认值或提示用户
    final customerActiveCode = savedCustomerId ?? 'DEFAULT_CUSTOMER_ID';

    final patientNotifier = ref.read(patientProvider.notifier);

    // 调用provider的loadPatients方法，传递搜索参数
    await patientNotifier.loadPatients(
      customerActiveCode: customerActiveCode,
      searchKeyword: searchKeyword ?? _searchController.text.trim(),
      wardIdList: wardIdList ?? (_selectedWardId != null ? [_selectedWardId!] : null),
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
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedWardId,
                      hint: Text('请选择病区', style: TextStyle(fontSize: 15.sp)),
                      items: [
                        DropdownMenuItem<String>(
                          value: null,
                          child: Text('全部病区', style: TextStyle(fontSize: 15.sp)),
                        ),
                        ..._wardIds.map(
                          (wardId) => DropdownMenuItem<String>(
                            value: wardId,
                            child: Text(wardId, style: TextStyle(fontSize: 15.sp)),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedWardId = value;
                        });
                      },
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // 实现查询功能
                    _performSearch();
                  },
                  child: Text(
                    '查询',
                    style: TextStyle(fontSize: 15.sp, color: const Color(0xFF0073CF)),
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
        unselectedLabelStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.normal),
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
              _currentIndex == 0 ? 'assets/icons/ic_pat_scan.png' : 'assets/icons/ic_pat_add.png',
              width: 20.w,
              height: 20.h,
              errorBuilder: (context, error, stackTrace) {
                return Icon(_currentIndex == 0 ? Icons.qr_code_scanner : Icons.add, color: Colors.white, size: 20.w);
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
      return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0073CF))));
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
        return PatientListItem(patient: patient, onTap: () => _handlePatientTap(patient), onMeasureTap: () => _handleMeasureTap(patient));
      },
    );
  }

  /// 执行搜索
  void _performSearch() {
    final searchKeyword = _searchController.text.trim();
    final wardIdList = _selectedWardId != null ? [_selectedWardId!] : null;

    _loadPatients(searchKeyword: searchKeyword, wardIdList: wardIdList);

    // 显示搜索反馈
    if (searchKeyword.isNotEmpty || wardIdList != null) {
      final feedback = searchKeyword.isNotEmpty ? '搜索关键词: $searchKeyword' : '筛选病区: $_selectedWardId';

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('正在$feedback'), duration: Duration(seconds: 1)));
    }
  }

  void _handleScan() {
    // 实现扫描功能
    _showScanDialog();
  }

  /// 显示扫描对话框
  void _showScanDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('扫描患者二维码'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.qr_code_scanner, size: 60.w, color: const Color(0xFF0073CF)),
              SizedBox(height: 20.h),
              Text(
                '请将摄像头对准患者的二维码进行扫描',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('取消')),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // 模拟扫描结果
                _simulateScanResult();
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0073CF)),
              child: Text('模拟扫描'),
            ),
          ],
        );
      },
    );
  }

  /// 模拟扫描结果
  void _simulateScanResult() {
    // 模拟扫描到的患者ID
    final scannedPatientId = 'PAT_${DateTime.now().millisecondsSinceEpoch}';

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('扫描成功: $scannedPatientId'), backgroundColor: Colors.green, duration: Duration(seconds: 2)));

    // TODO: 实际开发中这里应该根据扫描结果查询患者信息
    // 可以调用API获取患者详细信息
  }

  void _handleSearch() {
    // 实现搜索功能 - 弹出搜索对话框
    _showSearchDialog();
  }

  /// 显示搜索对话框
  void _showSearchDialog() {
    final tempController = TextEditingController(text: _searchController.text);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('搜索患者'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tempController,
                decoration: InputDecoration(
                  labelText: '请输入患者姓名或ID',
                  hintText: '支持模糊搜索',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                ),
              ),
              SizedBox(height: 20.h),
              // 病区筛选
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '筛选病区:',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        FilterChip(
                          label: Text('全部'),
                          selected: _selectedWardId == null,
                          onSelected: (selected) {
                            if (selected) {
                              _selectedWardId = null;
                            }
                          },
                        ),
                        ..._wardIds.map(
                          (wardId) => FilterChip(
                            label: Text(wardId),
                            selected: _selectedWardId == wardId,
                            onSelected: (selected) {
                              setState(() {
                                _selectedWardId = selected ? wardId : null;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('取消')),
            ElevatedButton(
              onPressed: () {
                // 更新搜索条件
                setState(() {
                  _searchController.text = tempController.text;
                });

                Navigator.of(context).pop();

                // 执行搜索
                _performSearch();
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0073CF)),
              child: Text('搜索'),
            ),
          ],
        );
      },
    );
  }

  void _handlePatientTap(Patient patient) {
    // 实现跳转到患者详情页面
    _navigateToPatientDetail(patient);
  }

  /// 跳转到患者详情页面
  void _navigateToPatientDetail(Patient patient) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 头部
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '患者详情',
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.close)),
                ],
              ),
              Divider(),
              SizedBox(height: 16.h),

              // 患者基本信息
              _buildPatientInfoItem('姓名', patient.patientName),
              _buildPatientInfoItem('性别', patient.sexDesc ?? '未提供'),
              _buildPatientInfoItem('年龄', patient.ageDesc ?? '未提供'),
              _buildPatientInfoItem('住院流水号', patient.inSerialId?.toString() ?? '未提供'),
              _buildPatientInfoItem('床号', patient.bedCode),
              _buildPatientInfoItem('病区', patient.wardName ?? '未知'),
              _buildPatientInfoItem('科室', patient.deptName ?? '未知'),

              SizedBox(height: 20.h),

              // 操作按钮
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _handleEditPatient(patient);
                      },
                      child: Text('编辑信息'),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _handleMeasureTap(patient);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0073CF)),
                      child: Text('立即测量'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /// 构建患者信息项
  Widget _buildPatientInfoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          SizedBox(
            width: 80.w,
            child: Text(
              '$label:',
              style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  /// 编辑患者信息
  void _handleEditPatient(Patient patient) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('编辑患者 ${patient.patientName} 的信息'), backgroundColor: Colors.orange));
    // TODO: 实现具体的编辑功能
  }

  void _handleMeasureTap(Patient patient) {
    // 实现跳转到测量页面
    _navigateToMeasurement(patient);
  }

  /// 跳转到测量页面
  void _navigateToMeasurement(Patient patient) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 头部
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '血糖测量',
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.close)),
                ],
              ),
              Divider(),
              SizedBox(height: 16.h),

              // 患者信息
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(12.r)),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                      backgroundColor: const Color(0xFF0073CF),
                      child: Text(
                        patient.patientName.substring(0, 1),
                        style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            patient.patientName,
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '床号: ${patient.bedCode}',
                            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // 测量选项
              Text(
                '请选择测量类型:',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.h),

              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: [
                  ChoiceChip(
                    label: Text('空腹血糖'),
                    selected: false,
                    onSelected: (selected) {
                      if (selected) _performMeasurement(patient, '空腹血糖');
                    },
                  ),
                  ChoiceChip(
                    label: Text('餐后血糖'),
                    selected: false,
                    onSelected: (selected) {
                      if (selected) _performMeasurement(patient, '餐后血糖');
                    },
                  ),
                  ChoiceChip(
                    label: Text('睡前血糖'),
                    selected: false,
                    onSelected: (selected) {
                      if (selected) _performMeasurement(patient, '睡前血糖');
                    },
                  ),
                  ChoiceChip(
                    label: Text('随机血糖'),
                    selected: false,
                    onSelected: (selected) {
                      if (selected) _performMeasurement(patient, '随机血糖');
                    },
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // 手动输入按钮
              ElevatedButton.icon(
                onPressed: () => _showManualInput(patient),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0073CF), minimumSize: Size(double.infinity, 48.h)),
                icon: Icon(Icons.edit),
                label: Text('手动输入血糖值'),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 执行测量
  void _performMeasurement(Patient patient, String measurementType) {
    Navigator.of(context).pop(); // 关闭测量对话框

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('开始为 ${patient.patientName} 测量$measurementType'), backgroundColor: Colors.green, duration: Duration(seconds: 2)));

    // TODO: 实际开发中这里应该启动蓝牙设备连接或相应的测量流程
    // 模拟测量过程
    Future.delayed(Duration(seconds: 2), () {
      final result = (4.0 + Random().nextDouble() * 8.0).toStringAsFixed(1);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('${patient.patientName} 的$measurementType测量完成: ${result}mmol/L'), backgroundColor: Colors.blue, duration: Duration(seconds: 3)));
    });
  }

  /// 显示手动输入对话框
  void _showManualInput(Patient patient) {
    final textController = TextEditingController();

    Navigator.of(context).pop(); // 关闭测量对话框

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('手动输入血糖值'),
          content: TextField(
            controller: textController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: '血糖值 (mmol/L)',
              hintText: '请输入血糖测量结果',
              prefixIcon: Icon(Icons.monitor_heart),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('取消')),
            ElevatedButton(
              onPressed: () {
                final value = textController.text.trim();
                if (value.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('请输入血糖值')));
                  return;
                }

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('已记录 ${patient.patientName} 的血糖值: ${value}mmol/L'), backgroundColor: Colors.green));

                // TODO: 实际开发中这里应该调用API保存测量数据
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0073CF)),
              child: Text('保存'),
            ),
          ],
        );
      },
    );
  }
}
