// ignore_for_file: prefer_const_constructors

import 'package:dbestech/common/bg_container.dart';
import 'package:dbestech/common/shimmers/foodlist_shimmer.dart';
import 'package:dbestech/constants/uidata.dart';
import 'package:dbestech/hook/fetch_all_categories.dart';
import 'package:dbestech/hook/fetch_all_foods.dart';
import 'package:dbestech/views/home/widgets/food_tile.dart';
import 'package:dbestech/views/home/widgets/restaurants_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/app_style.dart';
import '../../common/reusable_text.dart';
import '../../constants/constants.dart';
import '../../hook/fetch_foods.dart';
import '../../models/foods_model.dart';
import '../../models/hook_models/hook_result.dart';

class RecommendationsPage extends HookWidget {
  const RecommendationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    FetchHook fetchFoods = useFetchAllFoods("41007431");
    List<FoodsModel>? foods = fetchFoods.data;
    bool isLoading = fetchFoods.isLoading;
    return Scaffold(
      backgroundColor: kSecondary,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: kSecondary,
        title: ReusableText(
          text: 'Recommendations',
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
                    foods!.length,
                    (i) {
                      FoodsModel food = foods[i];
                      return FoodTile(
                        food: food,
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
