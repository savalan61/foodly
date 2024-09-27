import 'dart:ffi';

import 'package:dbestech/common/shimmers/categories_shimmer.dart';
import 'package:dbestech/common/shimmers/foodlist_shimmer.dart';
import 'package:dbestech/hook/fetch_restaurants_byCode.dart';
import 'package:dbestech/models/restaurants_model.dart';
import 'package:dbestech/views/home/widgets/restaurant_widget.dart';
import 'package:dbestech/views/restaurant/restaurant_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/shimmers/nearby_shimmer.dart';
import 'category_widget.dart';

class NearbyRestaurantsWidgetList extends HookWidget {
  const NearbyRestaurantsWidgetList({super.key});

  @override
  Widget build(BuildContext context) {
    final useHookResult = useFetchRestaurantsByCode('3445');
    List<RestaurantsModel>? hockRestaurants = useHookResult.data;
    bool isLoading = useHookResult.isLoading;

    return Container(
      height: 190.h,
      padding: EdgeInsets.only(top: 10.h, left: 12.w),
      child: isLoading
          ? const NearbyShimmer()
          : hockRestaurants == null || hockRestaurants.isEmpty
              ? const Center(child: Text('No restaurants found'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: hockRestaurants.length,
                  itemBuilder: (context, i) {
                    RestaurantsModel restaurant = hockRestaurants[i];
                    return RestaurantWidget(
                      onTap: () {
                        Get.to(() => RestaurantPage(restaurantId: restaurant.id));
                      },
                      title: restaurant.title,
                      image: restaurant.imageUrl,
                      logo: restaurant.logoUrl,
                      time: restaurant.time,
                      rating: restaurant.ratingCount,
                    );
                  },
                ),
    );
  }
}
