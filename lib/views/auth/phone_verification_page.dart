import 'package:dbestech/common/app_style.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/controllers/phone_verification_controller.dart';
import 'package:dbestech/services/verification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:phone_otp_verification/phone_verification.dart';

class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final PhoneVerificationController phoneVerificationCtrl = Get.put(PhoneVerificationController());
  final VerificationService verificationService = VerificationService();
  String _verificationId = "";

  @override
  Widget build(BuildContext context) {
    return Obx(() => phoneVerificationCtrl.isLoading.value == false
        ? PhoneVerification(
            isFirstPage: false,
            enableLogo: false,
            themeColor: kPrimary,
            backgroundColor: kLightWhite,
            initialPageText: "Verify Phone Number",
            initialPageTextStyle: appStyle(20, kPrimary, FontWeight.bold),
            textColor: kDark,
            onSend: (String value) {
              phoneVerificationCtrl.setPhoneNumber(value);
              _verifyPhoneNumber(value);
            },
            onVerification: (String value) {
              submitVerificationCode(value);
            },
          )
        : Container(
            color: kLightWhite,
            width: 375.w,
            height: 825.h,
            child: const Center(child: CircularProgressIndicator())));
  }

  void _verifyPhoneNumber(String phoneNumber) async {
    try {
      await verificationService.verifyPhoneNumber(
        phoneNumber,
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
          });
          print('Verification code sent: $verificationId');
          Get.snackbar(
            'Success',
            'Verification code sent.',
            colorText: kLightWhite,
            backgroundColor: kPrimary,
            icon: const Icon(Ionicons.checkmark_done_outline),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Verification failed: ${e.message}');

          // Optionally, show a dialog or snackbar with error message
        },
      );
    } catch (e) {
      print('Error verifying phone number: ${e.toString()}');
      // Handle general errors here
    }
  }

  void submitVerificationCode(String code) async {
    try {
      await verificationService.verifySmsCode(_verificationId, code);
      print('Phone number verified successfully');
      // Navigate to the next screen or show success message
    } catch (e) {
      print('Phone number verification failed: ${e.toString()}');
      // Optionally, show a dialog or snackbar with error message
    }
  }
}
