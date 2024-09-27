// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dbestech/common/app_style.dart';
import 'package:dbestech/common/bg_container.dart';
import 'package:dbestech/common/reusable_text.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/controllers/registration_controller.dart';
import 'package:dbestech/views/auth/widgets/email_textField_widget.dart';
import 'package:dbestech/views/auth/widgets/password_textField_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../common/custome_button.dart';
import 'login_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final TextEditingController _emailController;

  late final TextEditingController _passController;
  late final TextEditingController _pass2Controller;
  late final TextEditingController _usernameController;

  final FocusNode _passFocusNode = FocusNode();
  final _regFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passController = TextEditingController();
    _pass2Controller = TextEditingController();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _pass2Controller.dispose();
    _passFocusNode.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RegistrationController registrationCtrl = Get.put(RegistrationController());
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimary,
        centerTitle: true,
        title: ReusableText(
          text: "Foodly Registration",
          style: appStyle(20, kLightWhite, FontWeight.bold),
        ),
      ),
      body: BgContainer(
        color: Colors.white,
        child: Form(
          key: _regFormKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            children: [
              SizedBox(height: 20.h),
              SizedBox(height: 100.h, child: Lottie.asset("assets/anime/delivery.json")),
              Column(
                children: [
                  SizedBox(height: 20.h),

                  /// Username Text Field
                  EmailTextFieldWidget(
                    hintText: "username",
                    isEmail: false,
                    prefixIcon: Icon(
                      CupertinoIcons.person,
                      size: 22.h,
                      color: kGrayLight,
                    ),
                    controller: _usernameController,
                  ),
                  SizedBox(height: 20.h),

                  /// Email Text Field
                  EmailTextFieldWidget(
                    isEmail: true,
                    hintText: "Email",
                    prefixIcon: Icon(
                      CupertinoIcons.mail,
                      size: 22.h,
                      color: kGrayLight,
                    ),
                    controller: _emailController,
                  ),
                  SizedBox(height: 20.h),

                  /// Password Text Field
                  PasswordTextFieldWidget(
                    controller: _passController,
                  ),
                  SizedBox(height: 20.h),

                  /// Password2 Text Field
                  PasswordTextFieldWidget(
                    rePass: true,
                    controller: _pass2Controller,
                  ),
                  SizedBox(height: 20.h),

                  /// Register Button
                  CustomeButton(
                    onTap: () {
                      if (_passController.text.toString() != _pass2Controller.text.toString()) {
                        Get.snackbar(
                          'Error',
                          'Passwords do not match!',
                          backgroundColor: kRed,
                          colorText: Colors.white,
                          icon: Icon(CupertinoIcons.exclamationmark_circle),
                        );
                      } else {
                        if (_regFormKey.currentState!.validate()) {
                          registrationCtrl.registerUser(
                            _usernameController.text.toString(),
                            _emailController.text.toString(),
                            _passController.text.toString(),
                          );
                        }
                      }
                    },
                    text: "R e g i s t e r",
                    btnWidth: 375.w,
                    btnHeight: 40.h,
                  ),
                  SizedBox(height: 50.h),

                  /// Got For Login
                  Text.rich(
                    TextSpan(
                      text: 'You have already an account, ',
                      style: appStyle(11, kDark, FontWeight.normal),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Go Login',
                          style: appStyle(12, Colors.blue, FontWeight.normal),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(() => LoginPage(),
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
            ],
          ),
        ),
      ),
    );
  }
}
