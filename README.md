# HDMP医疗设备管理系统 - Flutter版本

## 项目说明

这是HDMP医疗设备管理系统的Flutter版本，从Android原生项目迁移而来。

## 项目结构

`
lib/
 core/                    # 核心功能
    constants/          # 常量定义
       api_constants.dart
       app_constants.dart
    network/            # 网络层
       dio_client.dart
    database/           # 数据库
    utils/              # 工具类
    theme/              # 主题配置
       app_theme.dart
    routes/             # 路由配置
        app_router.dart
 data/                   # 数据层
    models/            # 数据模型
    repositories/      # 数据仓库
    datasources/       # 数据源
 domain/                # 领域层
    entities/          # 实体
    repositories/      # 仓库接口
    usecases/          # 用例
 presentation/          # 表现层
    pages/             # 页面
       splash/        # 启动页
       login/         # 登录页
       main/          # 主页
    widgets/           # 通用组件
    providers/         # 状态管理
 main.dart              # 应用入口

assets/
 images/                # 图片资源
 icons/                 # 图标资源
 fonts/                 # 字体资源
`

## 技术栈

- **Flutter SDK**: ^3.9.2
- **状态管理**: Provider + Riverpod
- **路由**: GoRouter
- **网络**: Dio + Retrofit
- **数据库**: Sqflite + Hive
- **图表**: FL Chart + Syncfusion Charts
- **蓝牙**: Flutter Blue Plus

## 开始使用

### 1. 安装依赖

`ash
cd D:\project\sino-dev\DMP\hdmp_device_flutter
flutter pub get
`

### 2. 运行项目

`ash
# Windows
flutter run -d windows

# Android
flutter run -d android

# iOS
flutter run -d ios
`

### 3. 构建APK (Android)

`ash
flutter build apk --release
`

### 4. 构建Windows应用

`ash
flutter build windows --release
`

## 主要功能模块

1. **患者管理** - 患者信息查看、编辑
2. **血糖测量** - 血糖数据采集和记录
3. **数据图表** - 血糖趋势分析
4. **设备管理** - 蓝牙设备连接管理
5. **会诊系统** - 医生会诊功能
6. **任务管理** - 医疗任务跟踪

## 配置说明

### API配置

在 lib/core/constants/api_constants.dart 中配置服务器地址：

`dart
static const String baseUrl = 'http://192.168.187.18:7009/';
`

### 主题配置

在 lib/core/theme/app_theme.dart 中自定义应用主题。

## 开发指南

### 代码规范

- 使用 lutter_lints 进行代码检查
- 遵循 Dart 官方代码风格
- 使用有意义的变量和函数命名

### 状态管理

推荐使用 Riverpod 进行状态管理：

`dart
final counterProvider = StateProvider<int>((ref) => 0);
`

### 网络请求

使用 Dio 进行网络请求：

`dart
final dio = DioClient().dio;
final response = await dio.get('/api/endpoint');
`

## 版本信息

- 版本号: 1.0.10
- 构建号: 10

## 联系方式

项目地址: D:\project\sino-dev\DMP\hdmp_device_flutter
