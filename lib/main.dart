// ignore_for_file: unused_local_variable

import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/controllers/login_controller.dart';
import 'package:dbestech/views/entryPoint.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

import 'controllers/tab_index_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TabIndexController tabIndexCtrl = Get.put(TabIndexController());
    final LoginController loginCtrl = Get.put(LoginController());

    return ScreenUtilInit(
      // designSize: const Size(448, 973.3),
      designSize: const Size(375, 825),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Foody',
          theme: ThemeData(
              scaffoldBackgroundColor: kOffWhite,
              iconTheme: const IconThemeData(color: kDark),
              primarySwatch: Colors.grey),
          home: child,
        );
      },
      child: defaultHome,
    );
  }
}

Widget defaultHome = MainScreen();
