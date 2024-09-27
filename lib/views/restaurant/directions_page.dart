import 'package:dbestech/models/restaurants_model.dart';
import 'package:flutter/material.dart';

class DirectionsPage extends StatelessWidget {
  const DirectionsPage({super.key, required this.restaurant});
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
