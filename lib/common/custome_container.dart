// ignore_for_file: prefer_const_constructors
// ignore_for_file: must_be_immutable

import 'package:dbestech/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomeContainer extends StatelessWidget {
  CustomeContainer({super.key, required this.containerContent, this.color});
  Widget containerContent;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 825.h * 0.80,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.r), bottomRight: Radius.circular(30.r)),
        child: Container(
          width: 375.w,
          color: color ?? kOffWhite,
          child: containerContent,
        ),
      ),
    );
  }
}

// class CustomeContainer extends StatelessWidget {
//   CustomeContainer({super.key, required this.containerContent, this.color});
//   Widget containerContent;
//   Color? color;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 375.w,
//       color: color ?? kOffWhite,
//       child: containerContent,
//     );
//   }
// }
