// ignore_for_file: prefer_const_constructors

import 'package:dbestech/common/shimmers/categories_shimmer.dart';
import 'package:dbestech/constants/uidata.dart';
import 'package:dbestech/hook/fetch_categories.dart';
import 'package:dbestech/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'category_widget.dart';

class CategoryList extends HookWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryHookResult = useFetchCategories();
    List<CategoriesModel>? apiCategories = categoryHookResult.data;
    final isLoading = categoryHookResult.isLoading;
    final error = categoryHookResult.error;
    return isLoading
        ? CategoriesShimmer()
        : Container(
            height: 80.h,
            padding: EdgeInsets.only(top: 10.h, left: 12.w),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                apiCategories!.length,
                (i) {
                  CategoriesModel apiCategory = apiCategories[i];
                  return CategoryWidget(category: apiCategory);
                },
              ),
            ),
          );
  }
}
