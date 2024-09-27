import 'package:dbestech/common/app_style.dart';
import 'package:dbestech/common/custome_container.dart';
import 'package:dbestech/common/reusable_text.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/controllers/login_controller.dart';
import 'package:dbestech/controllers/verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../common/custome_button.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final VerificationController verificationCtrl = Get.put(VerificationController());
    return CustomeContainer(
      color: Colors.white,
      containerContent: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: SizedBox(
          height: 825.h,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Lottie.asset("assets/anime/delivery.json"),
              SizedBox(height: 10.h),
              Center(
                child: ReusableText(
                  text: "Verify Your Account.",
                  style: appStyle(20, kPrimary, FontWeight.w600),
                ),
              ),
              SizedBox(height: 5.h),
              Center(
                child: ReusableText(
                    text: "Enter the 6-digit code sent to your email. ",
                    style: appStyle(10, kGray, FontWeight.normal)),
              ),
              SizedBox(height: 20.h),
              OtpTextField(
                numberOfFields: 6,
                borderColor: kPrimary,
                fieldWidth: 40.w,
                textStyle: appStyle(17, kDark, FontWeight.w600),
                onSubmit: (String verificationCode) {
                  verificationCtrl.setVerificationCode(verificationCode);
                }, // end onSubmit
              ),
              SizedBox(height: 90.h),
              CustomeButton(
                text: "V e r i f y  A C C O U N T",
                btnWidth: 375.w,
                btnHeight: 40.h,
                onTap: () {
                  /// verify function
                  verificationCtrl.verifyByOtp();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
