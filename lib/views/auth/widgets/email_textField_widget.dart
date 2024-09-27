import 'package:dbestech/common/app_style.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

class EmailTextFieldWidget extends StatelessWidget {
  EmailTextFieldWidget({
    super.key,
    this.onEditingComplete,
    this.keyboardType,
    this.initialValue,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.isEmail,
  });
  final void Function()? onEditingComplete;
  final TextInputType? keyboardType;
  final String? initialValue;
  final String? hintText;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  bool? isEmail = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kDark,
      textInputAction: TextInputAction.next,
      onEditingComplete: onEditingComplete,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      initialValue: initialValue,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $hintText';
        } else if (!GetUtils.isEmail(value) && isEmail == true) {
          return 'Please enter a valid $hintText';
        }
        return null;
      },
      style: appStyle(12, kDark, FontWeight.normal),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: appStyle(12, kGray, FontWeight.normal),
        prefixIcon: prefixIcon,
        isDense: true,
        contentPadding: EdgeInsets.all(6.h),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kRed, width: .5.w),
            borderRadius: BorderRadius.all(Radius.circular(12.r))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimary, width: .5.w),
            borderRadius: BorderRadius.all(Radius.circular(12.r))),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kRed, width: .5.w),
            borderRadius: BorderRadius.all(Radius.circular(12.r))),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kGray, width: .5.w),
            borderRadius: BorderRadius.all(Radius.circular(12.r))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimary, width: .5.w),
            borderRadius: BorderRadius.all(Radius.circular(12.r))),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimary, width: .5.w),
            borderRadius: BorderRadius.all(Radius.circular(12.r))),
      ),
    );
  }
}
