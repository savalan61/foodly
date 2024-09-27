import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/models/api_error.dart';
import 'package:dbestech/models/foods_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import '../models/hook_models/hook_result.dart';

FetchHook useFetchFoodsByRestaurantId(String restaurantId) {
  final foods = useState<List<FoodsModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse('$appBaseUrl/api/foods/restaurant-foods/$restaurantId');

      final response = await http.get(url);
      if (response.statusCode == 200) {
        foods.value = foodsModelFromJson(response.body);
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
    // Future.delayed(const Duration(seconds: 3));

    fetchData();
    return null;
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchHook(
      data: foods.value, isLoading: isLoading.value, error: error.value, reFetch: refetch);
}
