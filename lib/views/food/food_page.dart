// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dbestech/common/app_style.dart';
import 'package:dbestech/common/custome_button.dart';
import 'package:dbestech/common/custome_textField.dart';
import 'package:dbestech/common/reusable_text.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/controllers/login_controller.dart';
import 'package:dbestech/models/foods_model.dart';
import 'package:dbestech/views/auth/login_page.dart';
import 'package:dbestech/views/auth/phone_verification_page.dart';
import 'package:dbestech/views/auth/verification_page.dart';
import 'package:dbestech/views/profile/profile_page.dart';
import 'package:dbestech/views/restaurant/restaurant_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/foods_controller.dart';
import '../../models/login_response_model.dart';

class FoodPage extends StatelessWidget {
  FoodPage({super.key, required this.food});

  final FoodsModel food;
  final TextEditingController preferencesCtrl = TextEditingController();
  final foodCtrl = Get.put(FoodsController());
  final GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      foodCtrl.loadAdditives(food.additives);
      foodCtrl.setFoodQuantity = 1;
    });

    // LoginController loginCtrl = Get.find<LoginController>();
    // LoginResponseModel? loggedUser = loginCtrl.getUserInfo();
    final bool? phoneVerification = box.read("PhoneVerification");
    final bool? verification = box.read("verification");
    final String? userId = box.read("userId");

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          /// Image
          ClipRRect(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30.r)),
            child: Stack(
              children: [
                /// Pictures
                SizedBox(
                  height: 230.h,
                  child: PageView.builder(
                    itemCount: food.imageUrl.length,
                    onPageChanged: (index) {
                      foodCtrl.setTabIndex = index;
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        height: 230.h,
                        width: 375.w,
                        color: kLightWhite,
                        child: CachedNetworkImage(
                          imageUrl: food.imageUrl[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),

                /// Dotes
                Positioned(
                  bottom: 10.w,
                  left: 10.w,
                  child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        food.imageUrl.length,
                        (index) {
                          return Container(
                            width: 10.h,
                            height: 10.h,
                            margin: EdgeInsets.all(4.h),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: foodCtrl.tabIndex == index ? kSecondary : kGrayLight,
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ),

                /// Back Button
                Positioned(
                  top: 40,
                  left: 12,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                      // foodCtrl.setFoodQuantity = 0;
                    },
                    child: Icon(
                      Ionicons.chevron_back_circle,
                      size: 30.w,
                      color: kPrimary, // Adjust icon size if needed
                    ),
                  ),
                ),

                /// Go to Restaurant
                Positioned(
                    right: 12.w,
                    bottom: 10.h,
                    child: CustomeButton(
                      btnWidth: 130.w,
                      text: "Go to Restaurant",
                      onTap: () {
                        Get.to(() => RestaurantPage(restaurantId: food.restaurantId));
                      },
                    ))
              ],
            ),
          ),

          /// Details
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),

                /// Food Price and name
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(text: food.title, style: appStyle(18, kDark, FontWeight.w600)),
                    Obx(() {
                      return ReusableText(
                          text:
                              "\$ ${((food.price + foodCtrl.totalPrice.value) * foodCtrl.foodQuantity).toStringAsFixed(2)}",
                          style: appStyle(18, kPrimary, FontWeight.w600));
                    }),
                  ],
                ),
                SizedBox(height: 5.h),

                /// Food Description
                Text(
                  food.description,
                  textAlign: TextAlign.justify,
                  maxLines: 8,
                  style: appStyle(11, kGrayLight, FontWeight.w400),
                ),
                SizedBox(height: 5.h),

                /// Tags
                SizedBox(
                  height: 20.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      food.foodTags.length,
                      (index) {
                        var tag = food.foodTags[index];
                        return Container(
                          margin: EdgeInsets.only(right: 5.w),
                          decoration: BoxDecoration(
                              color: kPrimary,
                              borderRadius: BorderRadius.all(Radius.circular(10.r))),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.w),
                              child: ReusableText(
                                text: tag,
                                style: appStyle(11, kWhite, FontWeight.w400),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15.h),

                ///Additives
                ReusableText(
                    text: "Additives and Toppings", style: appStyle(18, kDark, FontWeight.w600)),
                SizedBox(height: 10.h),
                Obx(() {
                  return Column(
                    children: List.generate(
                      foodCtrl.additivesObsList.length,
                      (index) {
                        var additiveObs = foodCtrl.additivesObsList[index];
                        return CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          value: additiveObs.isChecked.value,
                          dense: true,
                          tristate: false,
                          activeColor: kSecondary,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ReusableText(
                                  text: additiveObs.title,
                                  style: appStyle(11, kDark, FontWeight.w400)),
                              ReusableText(
                                  text: "\$${additiveObs.price}",
                                  style: appStyle(11, kPrimary, FontWeight.w600)),
                            ],
                          ),
                          onChanged: (value) {
                            additiveObs.toggleChecked();
                            additiveObs.isChecked.value
                                ? foodCtrl.totalPrice.value +=
                                    double.tryParse(additiveObs.price) ?? 0.0
                                : foodCtrl.totalPrice.value -=
                                    double.tryParse(additiveObs.price) ?? 0.0;
                          },
                        );
                      },
                    ),
                  );
                }),
                SizedBox(height: 20.h),

                /// Quantity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(text: "Quantity", style: appStyle(18, kDark, FontWeight.w600)),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              foodCtrl.updateFoodQuantity(false);
                            },
                            child: const Icon(AntDesign.minuscircleo)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Obx(() {
                            return ReusableText(
                                text: "${foodCtrl.foodQuantity}",
                                style: appStyle(14, kDark, FontWeight.w600));
                          }),
                        ),
                        GestureDetector(
                            onTap: () {
                              foodCtrl.updateFoodQuantity(true);
                            },
                            child: const Icon(AntDesign.pluscircleo)),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20.h),

                ///Preferences
                ReusableText(text: "Preferences", style: appStyle(14, kDark, FontWeight.w600)),
                SizedBox(height: 5.h),
                SizedBox(
                  height: 55.h,
                  child: CustomeTextField(
                    hintText: "Add a note with your preferences.",
                    maxLines: 3,
                    controller: preferencesCtrl,
                  ),
                ),
                SizedBox(height: 15.h),

                /// Pace Order
                Container(
                  height: 40.h,
                  decoration:
                      BoxDecoration(color: kPrimary, borderRadius: BorderRadius.circular(30.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print(
                              "userId = $userId, verification = $verification, phoneVerification = $phoneVerification");
                          if (userId == "") {
                            Get.to(() => LoginPage());
                          } else if (verification == false) {
                            Get.to(() => ProfilePage());
                          } else if (phoneVerification == null) {
                            showVerificationSheet(context);
                          } else {
                            print("Pacing order");
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: ReusableText(
                              text: "Place Order",
                              style: appStyle(18, kLightWhite, FontWeight.w600)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundColor: kSecondary,
                          radius: 20,
                          child: Icon(
                            Ionicons.cart,
                            color: kLightWhite,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  ///Show Modal For Phone Verification
  Future<dynamic> showVerificationSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        showDragHandle: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            width: 375.w,
            height: 500.h,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/restaurant_bk.png"), fit: BoxFit.fill),
                color: kWhite,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.r), topLeft: Radius.circular(12.r))),
            child: Padding(
              padding: EdgeInsets.all(8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10.h),
                  ReusableText(
                    text: "Verify Your Phone Number",
                    style: appStyle(18, kPrimary, FontWeight.w600),
                  ),
                  SizedBox(
                      height: 250.h,
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            verificationReasons.length,
                            (index) => ListTile(
                              leading: Icon(
                                Icons.check_circle_outline,
                                color: kPrimary,
                              ),
                              title: Text(verificationReasons[index],
                                  textAlign: TextAlign.justify,
                                  style: appStyle(11, kGrayLight, FontWeight.normal)),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 10.h),
                  CustomeButton(
                    text: "Verify Phone Number",
                    btnHeight: 35.h,
                    onTap: () {
                      Get.to(() => PhoneVerificationPage());
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
