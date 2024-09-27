import 'package:dbestech/common/shimmers/shimmer_widget.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodsListShimmer extends StatelessWidget {
  const FoodsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, top: 10),
      height: 825.h,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.zero,
          itemCount: 6,
          itemBuilder: (context, index) {
            return ShimmerWidget(shimmerWidth: 375.w, shimmerHeight: 70.h, shimmerRadius: 12);
          }),
    );
  }
}
