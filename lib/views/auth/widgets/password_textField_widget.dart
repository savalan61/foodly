import 'package:dbestech/common/app_style.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/controllers/password_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PasswordTextFieldWidget extends StatelessWidget {
  PasswordTextFieldWidget({
    super.key,
    this.controller,
    this.rePass,
  });

  final TextEditingController? controller;
  bool? rePass = false;

  @override
  Widget build(BuildContext context) {
    PasswordController passCtrl = Get.put(PasswordController());
    return Obx(() {
      return TextFormField(
        cursorColor: kDark,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.visiblePassword,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        obscureText: passCtrl.obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your password ${rePass == true ? "again" : ""}";
          } else if (value.length < 8) {
            return "Password must be at least 8 characters long";
          }
          return null;
        },
        style: appStyle(12, kDark, FontWeight.normal),
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: appStyle(12, kGray, FontWeight.normal),
          prefixIcon: const Icon(
            CupertinoIcons.lock_circle,
            size: 26,
            color: kGrayLight,
          ),
          suffixIcon: GestureDetector(
            onTap: passCtrl.toggleObscureText,
            child: passCtrl.obscureText
                ? const Icon(
                    Icons.visibility_off,
                    size: 26,
                    color: kGrayLight,
                  )
                : const Icon(
                    Icons.visibility,
                    size: 26,
                    color: kGrayLight,
                  ),
          ),
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
    });
  }
}
