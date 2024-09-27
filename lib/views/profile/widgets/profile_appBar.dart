import 'package:dbestech/common/app_style.dart';
import 'package:dbestech/common/reusable_text.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375.w,
      height: 90.h,
      child: AppBar(
        backgroundColor: kLightWhite,
        elevation: 0,
        toolbarHeight: 100.h,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/usa.svg",
                  width: 15.w,
                  height: 25.h,
                ),
                SizedBox(width: 5.w),
                Container(width: 1, height: 15.h, color: kGrayLight),
                SizedBox(width: 5.w),
                ReusableText(text: "USA", style: appStyle(16, kDark, FontWeight.normal)),
                SizedBox(width: 5.w),
                GestureDetector(onTap: () {}, child: Icon(SimpleLineIcons.settings, size: 16.h)),
                SizedBox(width: 18.w),
              ],
            ),
          )
        ],
      ),
    );
  }
}
