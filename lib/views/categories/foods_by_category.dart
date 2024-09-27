import 'package:dbestech/common/shimmers/foodlist_shimmer.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/models/foods_model.dart';
import 'package:dbestech/views/home/widgets/food_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../hook/fetch_foods_byCategory.dart';
import '../../models/hook_models/hook_result.dart';

class FoodsByCategory extends HookWidget {
  const FoodsByCategory(this.category, {super.key});
  final String category;

  @override
  Widget build(BuildContext context) {
    print("cat ıd:$category");
    FetchHook fetchFoods = useFetchFoodsByCategory(category, "41007434");
    List<FoodsModel>? foods = fetchFoods.data;
    bool isLoading = fetchFoods.isLoading;
    return isLoading
        ? const FoodsListShimmer()
        : SizedBox(
            height: 825.h,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: List.generate(
                foods!.length,
                (i) {
                  FoodsModel food = foods[i];
                  return FoodTile(
                    food: food,
                    color: Colors.white,
                  );
                },
              ),
            ),
          );
  }
}
