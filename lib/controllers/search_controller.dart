import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/models/api_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/foods_model.dart';

class SearchFoodController extends GetxController {
  final TextEditingController textEditingController = TextEditingController();
  final RxBool _isLoading = false.obs;
  RxList<FoodsModel> searchResult = <FoodsModel>[].obs;

  bool get isLoading => _isLoading.value;

  set setIsLoading(bool value) {
    _isLoading.value = value;
  }

  void searchFoods(String key) async {
    setIsLoading = true;
    Uri url = Uri.parse("$appBaseUrl/api/foods/search/$key");

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        searchResult.value = foodsModelFromJson(response.body);
      } else {
        var error = apiErrorFromJson(response.body);
        debugPrint(error.message.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setIsLoading = false;
    }
  }
}
