import 'package:dbestech/common/app_style.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomeTextField extends StatelessWidget {
  const CustomeTextField(
      {super.key,
      this.controller,
      this.keyboardType,
      this.onEditingCompleted,
      this.obscureText,
      this.suffixIcon,
      this.validator,
      this.prefixIcon,
      this.hintText,
      this.maxLines});

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function()? onEditingCompleted;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final int? maxLines;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.h),
      padding: EdgeInsets.only(left: 6.h),
      decoration: BoxDecoration(
          border: Border.all(color: kGray, width: 0.4), borderRadius: BorderRadius.circular(9.r)),
      child: TextFormField(
        maxLines: maxLines ?? 1,
        controller: controller,
        keyboardType: keyboardType,
        onEditingComplete: onEditingCompleted,
        obscureText: obscureText ?? false,
        cursorHeight: 20,
        style: appStyle(11, kDark, FontWeight.normal),
        validator: validator,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: appStyle(11, kDark, FontWeight.normal),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon),
      ),
    );
  }
}
