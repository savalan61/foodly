import 'package:dbestech/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375.w,
      height: 825.h,
      child: Padding(
        padding: EdgeInsets.only(bottom: 180.h),
        child: LottieBuilder.asset(
          "assets/anime/delivery.json",
          height: 825.h / 2,
          width: Checkbox.width,
        ),
      ),
    );
  }
}
