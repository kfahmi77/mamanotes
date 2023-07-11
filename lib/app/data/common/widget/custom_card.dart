import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/widgets.dart' as pw;
import '../style.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData iconData;
  final Color backgroundColor;
  final Color textColor;

  const CustomCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconData,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      color: backgroundColor,
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              iconData,
              size: 32,
              color: textColor,
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: redTextStyle.copyWith(
                fontSize: 18.sp,
                fontWeight: bold,
                color: textColor,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              style: redTextStyle.copyWith(
                fontWeight: normal,
                fontSize: 16.sp,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
