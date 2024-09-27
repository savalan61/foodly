import 'dart:convert';
import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/controllers/tab_index_controller.dart';
import 'package:dbestech/models/login_model.dart';
import 'package:dbestech/models/login_response_model.dart';
import 'package:dbestech/views/auth/verification_page.dart';
import 'package:dbestech/views/profile/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/api_error.dart';
import '../views/entryPoint.dart';

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;
  final box = GetStorage();

  /// Login the user using the provided email and password
  Future<void> loginUser(String email, String password) async {
    isLoading.value = true;

    final loginMode = LoginModel(email: email, password: password);

    try {
      final response = await http.post(
        Uri.parse('$appBaseUrl/login'),
        headers: {"Content-Type": "application/json"},
        body: loginModelToJson(loginMode),
      );

      if (response.statusCode == 200) {
        // Handle successful login
        LoginResponseModel loggedUser = loginResponseModelFromJson(response.body);
        box.write(loggedUser.id!, jsonEncode(loggedUser));
        box.write("token", loggedUser.userToken);
        box.write("userId", loggedUser.id);
        box.write("verification", loggedUser.verification);

        Get.snackbar(
          'Success',
          'User login successfully',
          colorText: kLightWhite,
          backgroundColor: kPrimary,
          icon: const Icon(Ionicons.fast_food_outline),
        );

        if (loggedUser.verification == false) {
          Get.to(() => MainScreen(),
              transition: Transition.fade, duration: const Duration(milliseconds: 900));
        } else if (loggedUser.verification == true) {
          Get.offAll(() => MainScreen(),
              transition: Transition.fade, duration: const Duration(milliseconds: 900));
        }
      } else {
        // Handle login error
        var error = apiErrorFromJson(response.body);
        Get.snackbar(
          'Error',
          error.message,
          colorText: kLightWhite,
          icon: const Icon(MaterialIcons.error_outline),
        );
        debugPrint(error.message.toString());
      }
    } catch (e) {
      // Handle any unexpected errors
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        colorText: kLightWhite,
        icon: const Icon(MaterialIcons.error_outline),
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Logout the user and clear the local storage
  void logOut() {
    box.erase();
    Get.offAll(() => MainScreen(),
        transition: Transition.fade, duration: const Duration(milliseconds: 900));
  }

  /// Retrieve user information from local storage
  LoginResponseModel? getUserInfo() {
    String? userId = box.read("userId");

    if (userId != null) {
      String? userData = box.read(userId);
      if (userData != null) {
        return loginResponseModelFromJson(userData);
      }
    }

    return null;
  }
}
