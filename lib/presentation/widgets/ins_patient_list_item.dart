import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/ins_patient.dart';

/// 胰岛素泵患者列表项Widget
class InsPatientListItem extends StatelessWidget {
  final InsPatient patient;
  final VoidCallback? onTap;
  final VoidCallback? onMeasureTap;

  const InsPatientListItem({super.key, required this.patient, this.onTap, this.onMeasureTap});

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
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 床号/ID和姓名
            Text(
              '${patient.bedCode ?? patient.id} ${patient.patientName}',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: const Color(0xFF17222D)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            // 年龄性别信息和科室病区
            SizedBox(height: 3.h),
            Text(
              '${patient.sexDesc ?? '未知'} ${patient.ageDesc ?? ''} ${patient.deptName ?? ''}${patient.wardName ?? ''}',
              style: TextStyle(fontSize: 13.sp, color: const Color(0xFF48505D)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            // 戴泵时间
            SizedBox(height: 14.h),
            Text(
              '戴泵 ${patient.useDayDesc ?? '0天0小时'}',
              style: TextStyle(fontSize: 13.sp, color: const Color(0xFF0073CF)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
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
