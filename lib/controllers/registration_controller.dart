import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/views/auth/login_page.dart';
import 'package:dbestech/views/profile/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../models/api_error.dart';
import '../models/registration_model.dart';

class RegistrationController extends GetxController {
  final RxBool isLoading = false.obs;
  // final box = GetStorage();

  Future<void> registerUser(String username, String email, String password) async {
    isLoading.value = true;

    final registrationModel = RegistrationModel(
      username: username,
      email: email,
      password: password,
    );

    try {
      final response = await http.post(
        Uri.parse('$appBaseUrl/register'),
        headers: {"Content-Type": "application/json"},
        body: registrationModelToJson(registrationModel),
      );

      if (response.statusCode == 200) {
        // Get.offAll(() => ProfilePage(),
        //     transition: Transition.fade, duration: const Duration(milliseconds: 900));
        Get.back();
        Get.snackbar('Success', 'Registered successfully',
            colorText: kLightWhite,
            backgroundColor: kPrimary,
            icon: const Icon(Ionicons.fast_food_outline));
      } else {
        Get.snackbar('Error', 'Failed to register user');
        var error = apiErrorFromJson(response.body);
        debugPrint(error.message.toString());
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
