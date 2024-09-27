import 'package:dbestech/common/shimmers/foodlist_shimmer.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/hook/fetch_foods.dart';
import 'package:dbestech/models/foods_model.dart';
import 'package:dbestech/views/home/widgets/food_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../hook/fetch_foods_by_RestaurantId.dart';
import '../../../models/hook_models/hook_result.dart';

class RestaurantExploreWidget extends HookWidget {
  const RestaurantExploreWidget(this.code, {super.key});
  final String code;

  @override
  Widget build(BuildContext context) {
    FetchHook fetchFoods = useFetchFoods(code);
    List<FoodsModel>? foods = fetchFoods.data;
    bool isLoading = fetchFoods.isLoading;

    return Scaffold(
      backgroundColor: kLightWhite,
      body: isLoading
          ? const FoodsListShimmer()
          : SizedBox(
              height: 825.h * .7,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10.h),
                itemCount: foods?.length ?? 0,
                itemBuilder: (context, index) {
                  FoodsModel foodsModel = foods![index];
                  return FoodTile(food: foodsModel);
                },
              ),
            ),
    );
  }
}
