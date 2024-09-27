// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dbestech/common/main_appbar.dart';
import 'package:dbestech/common/custome_container.dart';
import 'package:dbestech/common/heading.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/controllers/category_controller.dart';
import 'package:dbestech/views/categories/foods_by_category.dart';
import 'package:dbestech/views/home/all_fastest_foods_page.dart';
import 'package:dbestech/views/home/recommendations_page.dart';
import 'package:dbestech/views/home/widgets/category_list.dart';
import 'package:dbestech/views/home/widgets/food_list.dart';
import 'package:dbestech/views/home/widgets/nearby_restaurants_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'all_nearby_retaurants_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryCtrl = Get.put(CategoryController());
    return Scaffold(
      backgroundColor: kPrimary,

      /// App Bar
      appBar: PreferredSize(preferredSize: Size.fromHeight(190.h), child: MainAppbar()),

      body: SafeArea(
        child: CustomeContainer(
          containerContent: SingleChildScrollView(
            child: Column(
              children: [
                /// Category List Slider
                CategoryList(),

                /// Try Something New
                Obx(() {
                  return categoryCtrl.category.isEmpty
                      ? Column(
                          children: [
                            Heading(
                              text: 'Try Something New',
                              onTap: () {
                                Get.to(() => RecommendationsPage(),
                                    transition: Transition.cupertino,
                                    duration: Duration(milliseconds: 600));
                              },
                            ),
                            FoodWidgetList(),

                            /// Nearby Restaurants
                            Heading(
                              text: 'Nearby Restaurants',
                              onTap: () {
                                Get.to(() => AllNearbyRestaurantsPage(),
                                    transition: Transition.cupertino,
                                    duration: Duration(milliseconds: 600));
                              },
                            ),
                            NearbyRestaurantsWidgetList(),

                            /// Food Closer to You
                            Heading(
                              text: 'Food Closer to You',
                              onTap: () {
                                Get.to(() => AllFastestFoodsPage(),
                                    transition: Transition.cupertino,
                                    duration: Duration(milliseconds: 600));
                              },
                            ),
                            FoodWidgetList(),
                          ],
                        )
                      : Column(
                          children: [
                            Heading(
                              showMore: false,
                              text: 'Explore ${categoryCtrl.title} Category.',
                              onTap: () {
                                Get.to(() => RecommendationsPage(),
                                    transition: Transition.cupertino,
                                    duration: Duration(milliseconds: 600));
                              },
                            ),
                            SizedBox(
                              height: 825.h,
                              child: Padding(
                                padding: EdgeInsets.all(12.w),
                                child: FoodsByCategory(categoryCtrl.category),
                              ),
                            ),
                          ],
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
