import 'package:dbestech/models/additivesObs_model.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../models/foods_model.dart';

class FoodsController extends GetxController {
  final RxInt _tabIndex = 0.obs;

  int get tabIndex => _tabIndex.value;

  set setTabIndex(int newIndex) => _tabIndex.value = newIndex;

  final RxInt _foodCount = 1.obs;
  int get foodQuantity => _foodCount.value;

  set setFoodQuantity(int newQuantity) => _foodCount.value = newQuantity;
  updateFoodQuantity(bool increase) => increase
      ? _foodCount.value < 10
          ? _foodCount.value++
          : _foodCount.value = 10
      : _foodCount.value > 2
          ? _foodCount.value--
          : _foodCount.value = 1;

  /// Check Box handler
  bool initialCheckValue = false;
  var additivesObsList = <AdditivesObs>[].obs;
  RxDouble totalPrice = 0.0.obs;

  void loadAdditives(List<Additive> additives) {
    additivesObsList.clear();
    for (var additiveInfo in additives) {
      var additive = AdditivesObs(
        id: additiveInfo.id,
        title: additiveInfo.title,
        price: additiveInfo.price,
        checked: initialCheckValue,
      );
      additivesObsList.add(additive);
    }
  }
}
