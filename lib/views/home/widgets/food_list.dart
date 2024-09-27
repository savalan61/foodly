import 'package:dbestech/common/shimmers/foodlist_shimmer.dart';
import 'package:dbestech/common/shimmers/nearby_shimmer.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/constants/uidata.dart';
import 'package:dbestech/hook/fetch_foods.dart';
import 'package:dbestech/models/foods_model.dart';
import 'package:dbestech/models/hook_models/hook_result.dart';
import 'package:dbestech/views/food/food_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'category_widget.dart';
import 'food_widget.dart';

class FoodWidgetList extends HookWidget {
  const FoodWidgetList({super.key});

  @override
  Widget build(BuildContext context) {
    FetchHook fetchFoods = useFetchFoods("3434");
    List<FoodsModel>? foods = fetchFoods.data;
    bool isLoading = fetchFoods.isLoading;
    return isLoading
        ? const NearbyShimmer()
        : Container(
            height: 184.h,
            padding: EdgeInsets.only(top: 10.h, left: 8.w),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                foods!.length,
                (i) {
                  FoodsModel food = foods[i];
                  return FoodWidget(
                    onTap: () {
                      Get.to(() => FoodPage(food: food));
                    },
                    image: food.imageUrl[0],
                    title: food.title,
                    time: food.time,
                    price: food.price.toStringAsFixed(2),
                  );
                },
              ),
            ),
          );
  }
}
