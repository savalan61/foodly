// ignore_for_file: prefer_const_constructors

import 'package:dbestech/common/app_style.dart';
import 'package:dbestech/common/bg_container.dart';
import 'package:dbestech/common/reusable_text.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/shimmers/foodlist_shimmer.dart';
import '../../hook/fetch_foods_byCategory.dart';
import '../../models/foods_model.dart';
import '../../models/hook_models/hook_result.dart';
import '../home/widgets/food_tile.dart';

class CategoryPage extends HookWidget {
  const CategoryPage({super.key, required this.category});
  final CategoriesModel category;
  @override
  Widget build(BuildContext context) {
    FetchHook fetchFoods = useFetchFoodsByCategory(category.id, "41007434");
    List<FoodsModel>? foods = fetchFoods.data;
    bool isLoading = fetchFoods.isLoading;
    return Scaffold(
        appBar: AppBar(
          title: ReusableText(
            text: '${category.title} Category',
            style: appStyle(13, kGray, FontWeight.w600),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: kOffWhite,
        ),
        body: BgContainer(
          color: Colors.white,
          child: SizedBox(
            height: 825.h,
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: isLoading
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
                            );
                          },
                        ),
                      ),
                    ),
            ),
          ),
        ));
  }
}
