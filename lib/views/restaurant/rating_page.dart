import 'package:dbestech/models/restaurants_model.dart';
import 'package:flutter/material.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({super.key, required this.restaurant});
  final RestaurantsModel restaurant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(restaurant.title),
      ),
    );
  }
}
