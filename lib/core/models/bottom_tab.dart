import 'package:flutter/material.dart';

/// 底部导航Tab数据模型
class BottomTab {
  final String title;
  final String iconAsset;
  final String activeIconAsset;
  final String route;
  final bool isCenter; // 是否为居中Tab

  const BottomTab({
    required this.title,
    required this.iconAsset,
    required this.activeIconAsset,
    required this.route,
    this.isCenter = false,
  });
}

/// 底部导航Tab常量
class BottomTabs {
  BottomTabs._();

  static const List<BottomTab> tabs = [
    BottomTab(
      title: '患者',
      iconAsset: 'assets/icons/tabs/pat_unselect.png',
      activeIconAsset: 'assets/icons/tabs/pat_select.png',
      route: '/main/patient',
      isCenter: false,
    ),
    BottomTab(
      title: '任务',
      iconAsset: 'assets/icons/tabs/task_unselect.png',
      activeIconAsset: 'assets/icons/tabs/task_select.png',
      route: '/main/tasks',
      isCenter: false,
    ),
    BottomTab(
      title: 'AI助手',
      iconAsset: 'assets/icons/tabs/ic_ai.png',
      activeIconAsset: 'assets/icons/tabs/ic_ai.png',
      route: '/main/ai',
      isCenter: true,
    ),
    BottomTab(
      title: '虚拟病房',
      iconAsset: 'assets/icons/tabs/blood_unselect.png',
      activeIconAsset: 'assets/icons/tabs/blood_select.png',
      route: '/main/virtual-ward',
      isCenter: false,
    ),
    BottomTab(
      title: '更多',
      iconAsset: 'assets/icons/tabs/more_unselect.png',
      activeIconAsset: 'assets/icons/tabs/more_select.png',
      route: '/main/more',
      isCenter: false,
    ),
  ];
}
