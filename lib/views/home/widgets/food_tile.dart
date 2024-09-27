import 'package:dbestech/common/app_style.dart';
import 'package:dbestech/common/reusable_text.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/models/foods_model.dart';
import 'package:dbestech/views/food/food_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class FoodTile extends StatelessWidget {
  const FoodTile({super.key, required this.food, this.color});
  final FoodsModel food;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print("object");
          Get.to(() => FoodPage(food: food));
        },
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8.h),
              width: 375.w,
              height: 70.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.r), color: color ?? kOffWhite),
              child: Container(
                padding: EdgeInsets.all(4.r),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12.r)),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 70.h,
                            width: 70.w,
                            child: food.imageUrl.isNotEmpty
                                ? Image.network(
                                    food.imageUrl[0],
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/No.png',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Positioned(
                              bottom: 0,
                              child: Container(
                                padding: EdgeInsets.only(left: 6.w, right: 2.w),
                                color: kGray.withOpacity(.6),
                                height: 16.h,
                                width: 375.w,
                                child: RatingBarIndicator(
                                  rating: 5,
                                  itemCount: 5,
                                  itemBuilder: (context, index) =>
                                      const Icon(Icons.star, color: kSecondary),
                                  itemSize: 15.h,
                                ),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                            text: food.title ?? 'No title',
                            style: appStyle(11, kDark, FontWeight.w400)),
                        ReusableText(
                            text: 'Delivery time: ${food.time}',
                            style: appStyle(11, kGray, FontWeight.w400)),
                        SizedBox(
                          width: 375.w * .7,
                          height: 15.h,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: food.additives.length,
                              itemBuilder: (context, i) {
                                var additive = food.additives[i];
                                return Container(
                                  margin: EdgeInsets.only(right: 5.w),
                                  decoration: BoxDecoration(
                                      color: kSecondaryLight,
                                      borderRadius: BorderRadius.all(Radius.circular(9.r))),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: ReusableText(
                                          text: additive.title,
                                          style: appStyle(8, kGray, FontWeight.w400)),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                right: 5,
                top: 6,
                child: Container(
                  width: 60.w,
                  height: 19.h,
                  decoration:
                      BoxDecoration(color: kPrimary, borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                    child: ReusableText(
                      text: '\$ ${food.price.toStringAsFixed(2)} ',
                      style: appStyle(12, kLightWhite, FontWeight.bold),
                    ),
                  ),
                )),
            Positioned(
                right: 75,
                top: 6,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 19.w,
                    height: 19.h,
                    decoration:
                        BoxDecoration(color: kSecondary, borderRadius: BorderRadius.circular(10.r)),
                    child: Center(
                      child: Icon(
                        MaterialCommunityIcons.cart_plus,
                        size: 15.h,
                        color: kLightWhite,
                      ),
                    ),
                  ),
                )),
          ],
        ));
  }
}
