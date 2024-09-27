// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dbestech/common/app_style.dart';
import 'package:dbestech/common/reusable_text.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowText extends StatelessWidget {
  const RowText({
    super.key,
    required this.firstText,
    required this.secondText,
  });
  final String firstText;
  final String secondText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReusableText(text: firstText, style: appStyle(10, kGray, FontWeight.w500)),
          ReusableText(text: secondText, style: appStyle(10, kGray, FontWeight.w500)),
        ],
      ),
    );
  }
}
