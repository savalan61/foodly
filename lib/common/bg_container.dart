import 'package:dbestech/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BgContainer extends StatelessWidget {
  const BgContainer({super.key, required this.child, required this.color});
  final Widget child;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      height: 825.h,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          image: const DecorationImage(
            image: AssetImage('assets/images/restaurant_bk.png'),
            fit: BoxFit.cover,
            opacity: .7,
          )),
      child: child,
    );
  }
}
