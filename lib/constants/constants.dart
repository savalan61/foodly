import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

String googleApiKey = '';

const kPrimary = Color(0xFF30b9b2);
// const kPrimary = Color(0xFF70b900);
const kPrimaryLight = Color(0xFF40F3EA);
const kSecondary = Color(0xffffa44f);
const kSecondaryLight = Color(0xFFffe5db);
const kTertiary = Color(0xff0078a6);
const kGray = Color(0xff83829A);
const kGrayLight = Color(0xffC1C0C8);
const kLightWhite = Color(0xffFAFAFC);
const kWhite = Color(0xfffFFFFF);
const kDark = Color(0xff000000);
const kRed = Color(0xffe81e4d);
const kOffWhite = Color(0xffF3F4F8);

// double height = Get.height;
// double width = Get.width;
//double height = 825.h;
//double width = 375.w;
//
// double width = MediaQuery.of(context).size.width;
// double height = MediaQuery.of(context).size.height;

final List<String> verificationReasons = [
  'Real-time Updates: Get instant notifications about your order status.',
  'Direct Communication: A verified number ensures seamless communication.',
  'Enhanced Security: Protect your account and confirm orders securely.',
  'Effortless Rescheduling: Easily address issues with a quick call.',
  'Exclusive Offers: Stay in the loop for special deals and promotions.'
];

// const String appBaseUrl = "http://10.0.2.2:6013";
// const String appBaseUrl = "http://192.168.1.7:6013";
const String appBaseUrl = "https://dbestech-backend.vercel.app";

// const String googleApi = "AIzaSyDWHu8S6BAmEPNN8egjYLT6qwS542OoWs4";
const String googleApi = "AIzaSyD9lPxeuUP_gPR6zwUKgd9DJCaw5uVsUb8";
