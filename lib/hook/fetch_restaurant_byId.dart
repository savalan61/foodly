import 'dart:convert';

import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/models/api_error.dart';
import 'package:dbestech/models/restaurants_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import '../models/hook_models/hook_result.dart';

FetchHook useFetchRestaurantById(String id) {
  final restaurant = useState<RestaurantsModel?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse('$appBaseUrl/api/restaurant/byId/$id');

      final response = await http.get(url);
      if (response.statusCode == 200) {
        restaurant.value =
            RestaurantsModel.fromJson(json.decode(response.body) as Map<String, dynamic>);
      } else {
        apiError.value = apiErrorFromJson(response.body);
      }
    } catch (err) {
      error.value = err as Exception?;
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, [id]);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchHook(
      data: restaurant.value, isLoading: isLoading.value, error: error.value, reFetch: refetch);
}
