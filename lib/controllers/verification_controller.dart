import 'package:dbestech/views/entryPoint.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../models/api_error.dart';

class VerificationController extends GetxController {
  final RxString verificationCode = "".obs;
  final RxBool isLoading = false.obs;
  final box = GetStorage();

  void setVerificationCode(String newCode) {
    verificationCode.value = newCode;
  }

  void verifyByOtp() async {
    String token = box.read("token");
    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse('$appBaseUrl/api/users/verify/${verificationCode.value}'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        box.write("verification", true);
        Get.snackbar(
          'Success',
          'OTP verified successfully',
          colorText: kLightWhite,
          backgroundColor: kPrimary,
          icon: const Icon(Ionicons.checkmark_done_outline),
        );
        Get.offAll(() => MainScreen());
      } else {
        var error = apiErrorFromJson(response.body);
        Get.snackbar(
          'Error',
          'Failed to verify OTP: ${error.message}',
          colorText: Colors.white,
          backgroundColor: Colors.red,
          icon: const Icon(Ionicons.close_circle_outline),
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Error verifying OTP: $error',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        icon: const Icon(Ionicons.close_circle_outline),
      );
      print('Error verifying OTP: $error');
    } finally {
      isLoading.value = false;
    }
  }
}
