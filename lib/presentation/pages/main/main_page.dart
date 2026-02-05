import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/models/bottom_tab.dart';
import 'tabs/patient_page.dart';
import 'tabs/tasks_page.dart';
import 'tabs/ai_assistant_page.dart';
import 'tabs/virtual_ward_page.dart';
import 'tabs/more_page.dart';

/// 主页面 - 底部导航
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late PageController _pageController;

  final List<Widget> _pages = const [
    PatientPage(),
    TasksPage(),
    AiAssistantPage(),
    VirtualWardPage(),
    MorePage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 主内容区域
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: _pages,
          ),

          // 居中悬浮的AI图标
          Positioned(
            bottom: 12.h, // 对应Android的marginBottom=12dp
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/icons/tabs/ic_ai.png',
                    width: 38.r,
                    height: 33.r,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 38.r,
                        height: 33.r,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0073CF),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: const Icon(
                          Icons.auto_awesome,
                          color: Colors.white,
                          size: 20,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 4.h), // 对应Android的marginTop=4dp
                  Text(
                    'AI助手',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF0073CF),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        height: 65.h,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/icons/tabs/ic_main_bg.png'),
            fit: BoxFit.fill,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: List.generate(BottomTabs.tabs.length, (index) {
            final tab = BottomTabs.tabs[index];
            final isSelected = _currentIndex == index;

            // 居中Tab特殊处理
            if (tab.isCenter) {
              return Expanded(
                child: Container(
                  height: 30.h, // 与Android的居中Tab高度一致
                  color: Colors.transparent,
                  alignment: Alignment.bottomCenter,
                ),
              );
            }

            return Expanded(
              child: GestureDetector(
                onTap: () => _onTabTapped(index),
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(
                          isSelected ? tab.activeIconAsset : tab.iconAsset,
                          width: 24.r,
                          height: 24.r,
                          color: isSelected
                              ? const Color(0xFF0073CF)
                              : const Color(0xFF999999),
                          errorBuilder: (context, error, stackTrace) {
                            print(
                              '图片加载失败: ${isSelected ? tab.activeIconAsset : tab.iconAsset}',
                            );
                            print('错误信息: $error');
                            return Icon(
                              isSelected ? Icons.circle : Icons.circle_outlined,
                              size: 24.r,
                              color: isSelected
                                  ? const Color(0xFF0073CF)
                                  : const Color(0xFF999999),
                            );
                          },
                        ),
                      ),
                      Text(
                        tab.title,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: isSelected
                              ? const Color(0xFF0073CF)
                              : const Color(0xFF999999),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
