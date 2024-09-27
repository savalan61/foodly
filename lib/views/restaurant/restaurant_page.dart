// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dbestech/common/app_style.dart';
import 'package:dbestech/common/reusable_text.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/hook/fetch_restaurant_byId.dart';
import 'package:dbestech/main.dart';
import 'package:dbestech/models/restaurants_model.dart';
import 'package:dbestech/views/entryPoint.dart';
import 'package:dbestech/views/home/home_page.dart';
import 'package:dbestech/views/restaurant/directions_page.dart';
import 'package:dbestech/views/restaurant/widgets/restaurant_buttom_bar_widget.dart';
import 'package:dbestech/views/restaurant/widgets/restaurant_explore_widget.dart';
import 'package:dbestech/views/restaurant/widgets/restaurant_menu_widget.dart';
import 'package:dbestech/views/restaurant/widgets/row_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class RestaurantPage extends HookWidget {
  const RestaurantPage({super.key, required this.restaurantId});

  final String restaurantId;

  @override
  Widget build(BuildContext context) {
    final useRestaurantFetchById = useFetchRestaurantById(restaurantId);
    RestaurantsModel? restaurant = useRestaurantFetchById.data;
    bool isLoading = useRestaurantFetchById.isLoading;

    final tabController = useTabController(initialLength: 2); // TabController

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kLightWhite,
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : restaurant != null
                ? ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      /// Top Section
                      Stack(
                        children: [
                          /// Image
                          SizedBox(
                            height: 230.h,
                            width: double.infinity,
                            child: CachedNetworkImage(
                              imageUrl: restaurant.imageUrl,
                              width: 375.w,
                              fit: BoxFit.cover,
                            ),
                          ),

                          /// Rating Bar
                          Positioned(bottom: 0, child: RestaurantBottomBar(restaurant: restaurant)),

                          /// Icons
                          Positioned(
                            top: 40.h,
                            child: SizedBox(
                              width: 375.w,
                              child: Stack(
                                children: [
                                  Container(
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          kSecondary.withOpacity(0.3),
                                          kSecondary.withOpacity(0.3)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () => Get.to(() => MainScreen()),
                                          child: Icon(
                                            Ionicons.chevron_back_circle,
                                            size: 28,
                                            color: kSecondary,
                                          ),
                                        ),
                                        ReusableText(
                                            text: restaurant.title,
                                            style: appStyle(13, kLightWhite, FontWeight.w600)),
                                        GestureDetector(
                                          onTap: () =>
                                              Get.to(() => DirectionsPage(restaurant: restaurant)),
                                          child: Icon(
                                            Ionicons.location,
                                            size: 28,
                                            color: kSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),

                      /// Details
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Column(
                          children: [
                            RowText(firstText: 'Distance to Restaurant:', secondText: '2.7 km'),
                            RowText(firstText: 'Estimated Price:', secondText: '\$ 30'),
                            RowText(firstText: 'Estimated Time:', secondText: '20 min'),
                            Divider(
                              thickness: 0.7,
                            )
                          ],
                        ),
                      ),

                      /// Tabs
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Container(
                          height: 25.h,
                          width: 375.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            color: kOffWhite,
                          ),
                          child: TabBar(
                            controller: tabController,
                            labelStyle: appStyle(12, kLightWhite, FontWeight.normal),
                            dividerColor: Colors.transparent,
                            indicator: BoxDecoration(
                                color: kPrimary, borderRadius: BorderRadius.circular(25.r)),
                            labelPadding: EdgeInsets.zero,
                            labelColor: kLightWhite,
                            unselectedLabelColor: kGrayLight,
                            tabs: [
                              Tab(
                                child: SizedBox(
                                  width: 375.w / 2,
                                  height: 25.h,
                                  child: Center(
                                    child: Text("Menu"),
                                  ),
                                ),
                              ),
                              Tab(
                                child: SizedBox(
                                  width: 375.w / 2,
                                  height: 25.h,
                                  child: Center(
                                    child: Text("Explore"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// Tab Items
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: SizedBox(
                          height: 825.h,
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              RestaurantMenuWidget(restaurant.id),
                              RestaurantExploreWidget(restaurant.code),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : Center(child: Text("Restaurant not found")),
      ),
    );
  }
}
