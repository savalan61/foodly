// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dbestech/common/app_style.dart';
import 'package:dbestech/common/bg_container.dart';
import 'package:dbestech/common/reusable_text.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/controllers/login_controller.dart';
import 'package:dbestech/views/auth/registration_page.dart';
import 'package:dbestech/views/auth/widgets/email_textField_widget.dart';
import 'package:dbestech/views/auth/widgets/password_textField_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../common/custome_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passController;
  final FocusNode _passFocusNode = FocusNode();
  final _logFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  //stateless widget does not need this:
  @override
  Widget build(BuildContext context) {
    LoginController loginCtrl = Get.find<LoginController>();
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimary,
        centerTitle: true,
        title: ReusableText(
          text: "Foodly Login",
          style: appStyle(20, kLightWhite, FontWeight.bold),
        ),
      ),
      body: BgContainer(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: [
            SizedBox(height: 30.h),
            SizedBox(height: 250, child: Lottie.asset("assets/anime/delivery.json")),
            Form(
              key: _logFormKey,
              child: Column(
                children: [
                  SizedBox(height: 30.h),

                  /// Email Text Field
                  EmailTextFieldWidget(
                    hintText: "Email...",
                    isEmail: true,
                    prefixIcon: Icon(
                      CupertinoIcons.mail,
                      size: 22.h,
                      color: kGrayLight,
                    ),
                    controller: _emailController,
                  ),
                  SizedBox(height: 30.h),

                  /// Password Text Field
                  PasswordTextFieldWidget(
                    controller: _passController,
                  ),
                  SizedBox(height: 30.h),

                  /// Login Button
                  CustomeButton(
                    onTap: () {
                      if (_logFormKey.currentState!.validate()) {
                        loginCtrl.loginUser(
                            _emailController.text.toString(), _passController.text.toString());
                      }
                    },
                    text: "L o g i n",
                    btnWidth: 375.w,
                    btnHeight: 40.h,
                  ),
                  SizedBox(height: 60.h),

                  /// Got For Register
                  Text.rich(
                    TextSpan(
                      text: 'If you haven\'t registered yet, Go ',
                      style: appStyle(11, kDark, FontWeight.normal),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Register',
                          style: appStyle(12, Colors.blue, FontWeight.normal),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(() => RegistrationPage(),
                                  transition: Transition.fadeIn,
                                  duration: Duration(milliseconds: 1200));
                            },
                        ),
                        TextSpan(
                          text: '',
                          style: appStyle(11, kDark, FontWeight.normal),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
