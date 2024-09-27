import 'package:dbestech/common/app_style.dart';
import 'package:dbestech/common/reusable_text.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ProfileTileWidget extends StatelessWidget {
  const ProfileTileWidget({super.key, required this.title, required this.icon, this.onTap});
  final String title;
  final IconData icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      onTap: onTap,
      minLeadingWidth: 0,
      leading: Icon(
        icon,
        size: 20.h,
      ),
      title: ReusableText(
        text: title,
        style: appStyle(11, kGray, FontWeight.normal),
      ),
      trailing: title != "Settings"
          ? Icon(
              AntDesign.right,
              size: 16.h,
            )
          : SvgPicture.asset(
              "assets/icons/usa.svg",
              width: 15.w,
              height: 25.h,
            ),
    );
  }
}
