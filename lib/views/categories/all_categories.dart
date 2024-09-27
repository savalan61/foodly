// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:dbestech/common/app_style.dart';
import 'package:dbestech/common/bg_container.dart';
import 'package:dbestech/common/reusable_text.dart';
import 'package:dbestech/common/shimmers/foodlist_shimmer.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/constants/uidata.dart';
import 'package:dbestech/hook/fetch_all_categories.dart';
import 'package:dbestech/models/categories_model.dart';
import 'package:dbestech/views/categories/category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AllCategories extends HookWidget {
  const AllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final allCategoryHookResult = useFetchAllCategories();
    List<CategoriesModel>? allCategories = allCategoryHookResult.data;
    final isLoading = allCategoryHookResult.isLoading;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: kOffWhite,
          title: ReusableText(text: 'Categories', style: appStyle(12.sp, kGray, FontWeight.w600)),
          centerTitle: true),
      body: BgContainer(
        color: Colors.white,
        child: isLoading
            ? FoodsListShimmer()
            : Container(
                padding: EdgeInsets.only(left: 12.w, top: 10.h),
                height: 825.h,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: List.generate(
                    allCategories!.length,
                    (i) {
                      CategoriesModel category = allCategories[i];
                      return CategoryTile(category: category);
                    },
                  ),
                ),
              ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.category,
  });

  final CategoriesModel category;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(
            () => CategoryPage(
                  category: category,
                ),
            duration: Duration(milliseconds: 900),
            transition: Transition.fadeIn);
      },
      leading: CircleAvatar(
        radius: 18.r,
        backgroundColor: kGrayLight,
        child: ClipOval(
          child: SizedBox(
            width: 36.r,
            height: 36.r,
            child: Image.network(
              category.imageUrl ?? '',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
            ),
          ),
        ),
      ),
      title: ReusableText(
        text: category.title ?? 'No Title',
        style: appStyle(12.sp, kGray, FontWeight.normal),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: kGray,
        size: 15.r,
      ),
    );
  }
}
