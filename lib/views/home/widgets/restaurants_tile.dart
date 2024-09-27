import 'package:cached_network_image/cached_network_image.dart';
import 'package:dbestech/common/app_style.dart';
import 'package:dbestech/common/reusable_text.dart';
import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/models/restaurants_model.dart';
import 'package:dbestech/views/restaurant/restaurant_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RestaurantsTile extends HookWidget {
  const RestaurantsTile({super.key, required this.restaurant});
  final RestaurantsModel restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.to(() => RestaurantPage(restaurantId: restaurant.id));
        },
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8.h),
              width: 375.w,
              height: 70.h,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(9.r), color: kOffWhite),
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
                            child: restaurant.imageUrl.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: restaurant.imageUrl,
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
                            text: restaurant.title ?? 'No title',
                            style: appStyle(11, kDark, FontWeight.w400)),
                        ReusableText(
                            text: 'Delivery time: ${restaurant.time}',
                            style: appStyle(11, kGray, FontWeight.w400)),
                        SizedBox(
                          width: 375.w * .7,
                          child: Text(restaurant.coords.address ?? '',
                              style: appStyle(9, kGray, FontWeight.w400),
                              overflow: TextOverflow.ellipsis),
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
                  decoration: BoxDecoration(
                      color: restaurant.isAvailable == true || restaurant.isAvailable == null
                          ? kPrimary
                          : kSecondaryLight,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                    child: ReusableText(
                      text: restaurant.isAvailable == true || restaurant.isAvailable == null
                          ? 'Open'
                          : 'Closed',
                      style: appStyle(12, kLightWhite, FontWeight.w600),
                    ),
                  ),
                ))
          ],
        ));
  }
}
