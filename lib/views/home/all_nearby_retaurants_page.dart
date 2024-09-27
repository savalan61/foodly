// ignore_for_file: prefer_const_constructors

import 'package:dbestech/common/bg_container.dart';
import 'package:dbestech/common/shimmers/foodlist_shimmer.dart';
import 'package:dbestech/constants/uidata.dart';
import 'package:dbestech/models/hook_models/hook_result.dart';
import 'package:dbestech/models/restaurants_model.dart';
import 'package:dbestech/views/home/widgets/restaurants_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/app_style.dart';
import '../../common/reusable_text.dart';
import '../../constants/constants.dart';
import '../../hook/fetch_all_Restaurants.dart';

class AllNearbyRestaurantsPage extends HookWidget {
  const AllNearbyRestaurantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    FetchHook fetchAllRes = useFetchAllRestaurants("345");
    List<RestaurantsModel>? allRestaurants = fetchAllRes.data;
    bool isLoading = fetchAllRes.isLoading;
    return Scaffold(
      backgroundColor: kSecondary,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: kSecondary,
        title: ReusableText(
          text: 'All Nearby Restaurants',
          style: appStyle(13, kLightWhite, FontWeight.w600),
        ),
      ),
      body: BgContainer(
        color: Colors.white,
        child: isLoading
            ? FoodsListShimmer()
            : Padding(
                padding: EdgeInsets.all(12.w),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: List.generate(
                    allRestaurants!.length,
                    (i) {
                      RestaurantsModel rest = allRestaurants[i];
                      return RestaurantsTile(
                        restaurant: rest,
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
