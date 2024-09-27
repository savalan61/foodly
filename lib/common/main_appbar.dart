import 'package:dbestech/common/app_style.dart';
import 'package:dbestech/common/reusable_text.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/controllers/user_location_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainAppbar extends StatefulWidget {
  const MainAppbar({super.key});

  @override
  State<MainAppbar> createState() => _MainAppbarState();
}

class _MainAppbarState extends State<MainAppbar> {
  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    final userLocationCtrl = Get.put(UserLocationController());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      height: 102.h,
      width: 375.w,
      color: kOffWhite,
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: kSecondary,
                  backgroundImage: NetworkImage("https://i.ibb.co/GJqQmfC/profile.jpg"),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 6.h, left: 8.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                          text: 'Deliver to', style: appStyle(13, kSecondary, FontWeight.w600)),
                      Obx(() {
                        return SizedBox(
                          width: 375.w * 0.60,
                          child: Text(
                              userLocationCtrl.address ??
                                  '16877 21s Ave N16877 21s Ave N16877 21s Ave N ',
                              style: appStyle(11, kGrayLight, FontWeight.normal),
                              overflow: TextOverflow.ellipsis),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
            Text(getTimeOfDay(), style: TextStyle(fontSize: 35))
          ],
        ),
      ),
    );
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    _getCurrentPosition();
  }

  Future<void> _getCurrentPosition() async {
    final userLocCtrl = Get.put(UserLocationController());

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    LatLng currentPosition = LatLng(position.latitude, position.longitude);
    userLocCtrl.setPosition(currentPosition);
    userLocCtrl.getUserAddress(currentPosition);
    print(currentPosition);
  }
}

String getTimeOfDay() {
  DateTime now = DateTime.now();
  var hour = now.hour;
  if (hour < 12) {
    return ' ☀️ ';
  } else if (hour >= 12 && hour < 16) {
    return ' ⛅ ';
  }
  return ' 🌙 ';
}
