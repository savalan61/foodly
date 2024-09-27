// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:dbestech/common/app_style.dart';
import 'package:dbestech/common/reusable_text.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/models/categories_model.dart';
import 'package:dbestech/views/categories/category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
        child: SizedBox(
          width: 36.r,
          height: 36.r,
          child: Image.network(
            category.imageUrl ?? '',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
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
