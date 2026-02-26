import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/cgm_patient.dart';

/// CGM患者列表项Widget
class CGMPatientListItem extends StatelessWidget {
  final CGMPatient patient;
  final VoidCallback? onTap;
  final VoidCallback? onMeasureTap;

  const CGMPatientListItem({
    super.key,
    required this.patient,
    this.onTap,
    this.onMeasureTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 床号和姓名
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${patient.bedNum} ${patient.patientName}',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF17222D),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            // 年龄性别信息
            SizedBox(height: 3.h),
            Row(
              children: [
                Text(
                  patient.patientAge ?? '',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF48505D),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                // 科室病区
                Text(
                  '${patient.deptName ?? ''} ${patient.wardName ?? ''}',
                  style: TextStyle(fontSize: 13.sp, color: const Color(0xFF48505D)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            SizedBox(height: 4.h),
            // CGM检测结果和状态
            if (patient.cgmStatus != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    patient.lastTestResult ?? '',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: _getBgColor(patient.cgmStatus),
                    ),
                  ),
                  Text(
                    '${patient.lastTestTime}天前',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ] else if (patient.isCgm == '1') ...[
              // CGM患者但无测试数据
              SizedBox(height: 4.h),
              Text(
                '初始化结束，未获取到...',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF999999),
                ),
              ),
            ],
            // CGM趋势图
            SizedBox(height: 8.h),
            SizedBox(
              height: 30.h,
              width: double.infinity,
              child: CustomPaint(
                painter: _TrendChartPainter(
                  data: _generateTrendData(),
                  lineColor: _getBgColor(patient.cgmStatus),
                  isEmpty: false,
                ),
              ),
            ),
            // 监测状态
            if (patient.cgmStatus != null) ...[
              SizedBox(height: 8.h),
              Text(
                '已完成监测',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF999999),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// 生成模拟的趋势数据
  List<double> _generateTrendData() {
    // 模拟CGM数据趋势
    final List<double> data = [];
    final Random random = Random();
    
    // 根据患者状态生成不同的数据
    for (int i = 0; i < 10; i++) {
      data.add(random.nextDouble() * 10 + 5);
    }
    
    return data;
  }

  /// 根据血糖状态获取颜色
  Color _getBgColor(String? status) {
    switch (status) {
      case 'high':
        return Colors.red;
      case 'low':
        return Colors.orange;
      case 'normal':
        return Colors.green;
      default:
        return const Color(0xFF48505D);
    }
  }
}

/// 绘制趋势图的自定义画家
class _TrendChartPainter extends CustomPainter {
  final List<double> data;
  final Color lineColor;
  final bool isEmpty;

  _TrendChartPainter({required this.data, required this.lineColor, this.isEmpty = false});

  @override
  void paint(Canvas canvas, Size size) {
    if (isEmpty || data.isEmpty) {
      return;
    }

    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double minValue = data.reduce((a, b) => a < b ? a : b);
    final double maxValue = data.reduce((a, b) => a > b ? a : b);
    final double range = maxValue - minValue;

    final path = Path();

    for (int i = 0; i < data.length; i++) {
      final double x = i * (size.width / (data.length - 1));
      final double y = size.height - ((data[i] - minValue) / range) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TrendChartPainter oldDelegate) {
    return oldDelegate.data != data || oldDelegate.lineColor != lineColor;
  }
}