// ignore_for_file: prefer_const_constructors

import 'package:dbestech/views/auth/verification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../common/custome_container.dart';
import '../../constants/constants.dart';
import '../../controllers/login_controller.dart';
import '../../models/login_response_model.dart';
import '../auth/login_redirect.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context) {
    LoginController loginCtrl = Get.find<LoginController>();

    LoginResponseModel? currentUser = loginCtrl.getUserInfo();

    if (currentUser == null) {
      return LoginRedirect();
    }

    // if (currentUser.verification == false) {
    //   print(currentUser.verification);
    //   print(currentUser.userName);
    //   return VerificationPage();
    // }
    final box = GetStorage();

    final bool verification = box.read("verification");
    if (verification == false) {
      return VerificationPage();
    }
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: PreferredSize(preferredSize: Size.fromHeight(90.h), child: Container(height: 90.h)),
      body: SafeArea(
        child: CustomeContainer(containerContent: Container()),
      ),
    );
  }
}
