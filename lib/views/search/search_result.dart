import 'package:dbestech/models/foods_model.dart';
import 'package:dbestech/views/home/widgets/food_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResult extends StatelessWidget {
  final List<FoodsModel> searchResult;

  const SearchResult({super.key, required this.searchResult});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.h, 0),
      child: ListView.builder(
        itemCount: searchResult.length,
        itemBuilder: (context, index) {
          FoodsModel food = searchResult[index];
          return FoodTile(food: food);
        },
      ),
    );
  }
}
