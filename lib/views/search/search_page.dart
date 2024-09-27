import 'package:dbestech/common/main_appbar.dart';
import 'package:dbestech/common/custome_textField.dart';
import 'package:dbestech/common/shimmers/foodlist_shimmer.dart';
import 'package:dbestech/controllers/search_controller.dart';
import 'package:dbestech/views/search/loading_widget.dart';
import 'package:dbestech/views/search/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import '../../common/custome_container.dart';
import '../../constants/constants.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchFoodController = Get.put(SearchFoodController());

    return Scaffold(
      backgroundColor: kPrimary,

      /// App Bar
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.h),
          child: AppBar(
            toolbarHeight: 90.h,
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: kOffWhite,
            title: Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: CustomeTextField(
                controller: searchFoodController.textEditingController,
                keyboardType: TextInputType.text,
                hintText: "Search Foods...",
                suffixIcon: Obx(() {
                  return GestureDetector(
                    onTap: () {
                      if (searchFoodController.searchResult.isNotEmpty) {
                        searchFoodController.searchResult.value = [];
                        searchFoodController.textEditingController.clear();
                      } else {
                        searchFoodController
                            .searchFoods(searchFoodController.textEditingController.text);
                      }
                    },
                    child: searchFoodController.searchResult.isEmpty
                        ? Icon(
                            Ionicons.search_circle,
                            size: 40.h,
                            color: kPrimary,
                          )
                        : Icon(
                            Ionicons.close,
                            size: 40.h,
                            color: Colors.red,
                          ),
                  );
                }),
              ),
            ),
          )),
      body: SafeArea(
        child: Obx(() {
          if (searchFoodController.isLoading) {
            return CustomeContainer(
              color: Colors.white,
              containerContent: const FoodsListShimmer(),
            );
          } else if (searchFoodController.searchResult.isEmpty ||
              searchFoodController.searchResult.isEmpty ||
              searchFoodController.textEditingController.text.isEmpty) {
            return CustomeContainer(color: Colors.white, containerContent: const LoadingWidget());
          } else {
            return CustomeContainer(
              color: Colors.white,
              containerContent: SearchResult(searchResult: searchFoodController.searchResult),
            );
          }
        }),
      ),
    );
  }
}
