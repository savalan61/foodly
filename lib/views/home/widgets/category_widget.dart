// ignore_for_file: prefer_const_constructors

import 'package:dbestech/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/app_style.dart';
import '../../../common/reusable_text.dart';
import '../../../constants/constants.dart';
import '../../../controllers/category_controller.dart';
import '../../categories/all_categories.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({super.key, required this.category});
  final catCtrl = Get.put(CategoryController());

  final CategoriesModel category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (catCtrl.category == category.id) {
          catCtrl.updateCategory = '';
          catCtrl.updateTitle = '';
        } else if (category.title == 'More') {
          Get.to(() => AllCategories(),
              transition: Transition.fadeIn, duration: const Duration(microseconds: 900));
        } else {
          catCtrl.updateCategory = category.id;
          catCtrl.updateTitle = category.title;
        }
      },
      child: Obx(() {
        return Container(
          margin: EdgeInsets.only(right: 5.w),
          padding: EdgeInsets.only(top: 4.h),
          width: 375.w * 0.19,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                  color: catCtrl.category == category.id ? kSecondary : kOffWhite, width: .5.w)),
          child: Column(
            children: [
              SizedBox(
                height: 35.h,
                child: Image.network(
                  category.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
              ReusableText(
                text: category.title,
                style: appStyle(12, kDark, FontWeight.normal),
              )
            ],
          ),
        );
      }),
    );
  }
}
