import 'package:dbestech/common/app_style.dart';
import 'package:dbestech/common/reusable_text.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomeButton extends StatelessWidget {
  final double? btnWidth;
  final double? btnHeight;
  final void Function()? onTap;
  final Color? color;
  final double? radius;

  final String text;
  const CustomeButton(
      {super.key,
      this.onTap,
      this.btnWidth,
      this.btnHeight,
      this.color,
      required this.text,
      this.radius});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: btnWidth ?? 375.w,
        height: btnHeight ?? 28.h,
        decoration: BoxDecoration(
          color: color ?? kPrimary,
          borderRadius: BorderRadius.circular(radius ?? 9.r),
        ),
        child: Center(
          child: ReusableText(
            text: text,
            style: appStyle(12, kLightWhite, FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
