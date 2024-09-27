import 'package:dbestech/common/app_style.dart';
import 'package:dbestech/common/custome_button.dart';
import 'package:dbestech/common/main_appbar.dart';
import 'package:dbestech/common/custome_textField.dart';
import 'package:dbestech/common/reusable_text.dart';
import 'package:dbestech/common/shimmers/foodlist_shimmer.dart';
import 'package:dbestech/controllers/search_controller.dart';
import 'package:dbestech/views/auth/login_page.dart';
import 'package:dbestech/views/search/loading_widget.dart';
import 'package:dbestech/views/search/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import '../../common/custome_container.dart';
import '../../constants/constants.dart';

class LoginRedirect extends StatelessWidget {
  const LoginRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,

      /// App Bar
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(90.h),
          child: AppBar(
              toolbarHeight: 90.h,
              // leading: GestureDetector(
              //   onTap: () => Get.back(),
              //   child: const Icon(
              //     AntDesign.left,
              //   ),
              // ),
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: ReusableText(
                text: "Please login to access this page",
                style: appStyle(12, kDark, FontWeight.w600),
              ))),
      body: SafeArea(
          child: Stack(
        children: [
          CustomeContainer(color: Colors.white, containerContent: const LoadingWidget()),
          Positioned(
            bottom: 120.h,
            right: 0,
            left: 0,
            child: Padding(
              padding: EdgeInsets.all(18.w),
              child: CustomeButton(
                onTap: () {
                  Get.to(() => LoginPage(),
                      transition: Transition.cupertino,
                      duration: const Duration(milliseconds: 900));
                },
                text: "L o g i n",
                btnWidth: 375.w * .75,
                btnHeight: 40.h,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
