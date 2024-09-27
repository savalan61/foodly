import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/custome_button.dart';
import '../../../constants/constants.dart';
import '../../../models/restaurants_model.dart';
import '../rating_page.dart';

class RestaurantBottomBar extends StatelessWidget {
  const RestaurantBottomBar({
    super.key,
    required this.restaurant,
  });

  final RestaurantsModel? restaurant;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      width: 375.w,
      height: 40.h,
      decoration: BoxDecoration(
          color: kPrimary.withOpacity(0.4),
          borderRadius:
              BorderRadius.only(topRight: Radius.circular(8.r), topLeft: Radius.circular(8.r))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RatingBarIndicator(
              itemCount: 5,
              itemSize: 25,
              rating: restaurant!.rating.toDouble(),
              itemBuilder: (context, i) => const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  )),
          CustomeButton(
            text: "Rate Restaurant",
            btnWidth: 375.w / 3,
            color: kSecondary,
            onTap: () {
              Get.to(() => RatingPage(restaurant: restaurant!));
            },
          )
        ],
      ),
    );
  }
}
