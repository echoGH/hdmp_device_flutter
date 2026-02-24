import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/patient.dart';

/// 患者列表项Widget
class PatientListItem extends StatelessWidget {
  final Patient patient;
  final VoidCallback? onTap;
  final VoidCallback? onMeasureTap;

  const PatientListItem({super.key, required this.patient, this.onTap, this.onMeasureTap});

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
            // 床号和姓名
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${patient.bedCode} ${patient.patientName}',
                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: const Color(0xFF17222D)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // CGM标签
                if (patient.isCgm == '1')
                  Container(
                    width: 23.w,
                    height: 19.h,
                    margin: EdgeInsets.only(left: 8.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9F2FB), // 半透明白色背景
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      '动',
                      style: TextStyle(fontSize: 12.sp, color: const Color(0xFF0073CF)), // 文字颜色：#0073CF
                    ),
                  ),
                // 胰岛素泵标签
                if (patient.isInsulinPump == '1')
                  Container(
                    width: 23.w,
                    height: 19.h,
                    margin: EdgeInsets.only(left: 8.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F9F8), // 半透明白色背景
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      '泵',
                      style: TextStyle(fontSize: 12.sp, color: const Color(0xFF21C4BB)), // 文字颜色：#21C4BB
                    ),
                  ),
              ],
            ),

            // 年龄性别信息
            SizedBox(height: 3.h),
            Row(
              children: [
                Text(
                  '${patient.sexDesc ?? '未知'} ${patient.ageDesc ?? ''}',
                  style: TextStyle(fontSize: 13.sp, color: const Color(0xFF48505D)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

            // 科室病区
            SizedBox(height: 14.h),
            Text(
              '${patient.deptName ?? ''} ${patient.wardName ?? ''}',
              style: TextStyle(fontSize: 13.sp, color: const Color(0xFF48505D)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            // 检测结果和时间
            if (patient.testInfo != null) ...[
              SizedBox(height: 6.h),
              Row(
                children: [
                  Text(
                    patient.testInfo!.testResult ?? '',
                    style: TextStyle(fontSize: 13.sp, color: _getBgColor(patient.testInfo!.aimStatus)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    patient.testInfo!.timeCodeName ?? '',
                    style: TextStyle(fontSize: 13.sp, color: const Color(0xFF48505D)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],

            // 任务统计和测量按钮
            SizedBox(height: 6.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '任务：${patient.bgmPlanFinishNum ?? '0'}/${patient.bgmPlanNum ?? '0'}',
                    style: TextStyle(fontSize: 13.sp, color: const Color(0xFF48505D)),
                  ),
                ),
                GestureDetector(
                  onTap: onMeasureTap,
                  child: Container(
                    width: 58.w,
                    height: 24.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F4FF), // 半透明白色背景
                      borderRadius: BorderRadius.circular(12.r), // 圆角半径12dp
                      border: Border.all(
                        color: const Color(0xFF0073CF), // 边框颜色：#0073CF
                        width: 0.5.w, // 边框宽度：0.5dp
                      ),
                    ),
                    child: Text(
                      '测量',
                      style: TextStyle(fontSize: 12.sp, color: const Color(0xFF0073CF)), // 文字颜色：#0073CF
                    ),
                  ),
                ),
              ],
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
