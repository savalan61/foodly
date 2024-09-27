// ignore_for_file: prefer_const_constructors

import 'package:dbestech/common/custome_button.dart';
import 'package:dbestech/controllers/login_controller.dart';
import 'package:dbestech/views/auth/login_redirect.dart';
import 'package:dbestech/views/auth/verification_page.dart';
import 'package:dbestech/views/profile/widgets/profile_appBar.dart';
import 'package:dbestech/views/profile/widgets/profile_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../common/app_style.dart';
import '../../common/custome_container.dart';
import '../../common/reusable_text.dart';
import '../../constants/constants.dart';
import '../../models/login_response_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginCtrl = Get.find<LoginController>();

    LoginResponseModel? currentUser = loginCtrl.getUserInfo();

    if (currentUser == null) {
      return LoginRedirect();
    }

    final box = GetStorage();
    final bool verification = box.read("verification");

    return Scaffold(
      backgroundColor: kPrimary,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.h),
          child: verification == false
              ? AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  actions: [
                    GestureDetector(
                        onTap: () {
                          loginCtrl.logOut();
                        },
                        child: const Icon(Icons.logout))
                  ],
                  title: ReusableText(
                    text: "Verification Page",
                    style: appStyle(12, kGray, FontWeight.w600),
                  ),
                  centerTitle: true,
                )
              : ProfileAppbar()),
      body: SafeArea(
        child: verification == false
            ? VerificationPage()
            : CustomeContainer(
                containerContent: Column(
                children: [
                  /// Picture
                  Container(
                    height: 825.h * 0.06,
                    width: 375.w,
                    color: kLightWhite,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              /// Pic
                              CircleAvatar(
                                radius: 22.r,
                                backgroundColor: kSecondary,
                                backgroundImage: NetworkImage(currentUser.profile!),
                              ),

                              ///  Address
                              Padding(
                                padding: EdgeInsets.only(bottom: 6.h, left: 8.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReusableText(
                                        text: currentUser.userName.toString(),
                                        style: appStyle(13, kSecondary, FontWeight.w600)),
                                    SizedBox(
                                      width: 375.w * 0.60,
                                      child: Text(currentUser.email.toString(),
                                          style: appStyle(11, kGrayLight, FontWeight.normal),
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.edit_calendar_outlined)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  /// First Section
                  Container(
                    height: 180.h,
                    decoration: BoxDecoration(color: kLightWhite),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ProfileTileWidget(
                          title: "My Orders",
                          icon: Ionicons.fast_food_outline,
                          onTap: () {
                            // Get.to(() => LoginRedirect());
                          },
                        ),
                        ProfileTileWidget(
                          title: "My Favorite Places",
                          icon: Ionicons.heart_outline,
                          onTap: () {},
                        ),
                        ProfileTileWidget(
                          title: "Reviews",
                          icon: Ionicons.chatbubble_outline,
                          onTap: () {},
                        ),
                        ProfileTileWidget(
                          title: "Coupons",
                          icon: MaterialCommunityIcons.tag_outline,
                          onTap: () {},
                        ),
                        SizedBox(height: 15.h),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),

                  /// Second Section
                  Container(
                    height: 180.h,
                    decoration: BoxDecoration(color: kLightWhite),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ProfileTileWidget(
                          title: "Shipping Address",
                          icon: SimpleLineIcons.location_pin,
                          onTap: () {},
                        ),
                        ProfileTileWidget(
                          title: "Service Center",
                          icon: AntDesign.customerservice,
                          onTap: () {},
                        ),
                        ProfileTileWidget(
                          title: "Coupons",
                          icon: MaterialCommunityIcons.tag_outline,
                          onTap: () {},
                        ),
                        ProfileTileWidget(
                          title: "Settings",
                          icon: AntDesign.setting,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  ///
                  CustomeButton(
                    text: "Logout",
                    radius: 0,
                    color: kRed,
                    onTap: () {
                      loginCtrl.logOut();
                    },
                  )
                ],
              )),
      ),
    );
  }
}
