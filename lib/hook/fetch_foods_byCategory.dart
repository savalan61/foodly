import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/models/api_error.dart';
import 'package:dbestech/models/foods_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import '../models/hook_models/hook_result.dart';

FetchHook useFetchFoodsByCategory(String category, String code) {
  final foods = useState<List<FoodsModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse('$appBaseUrl/api/foods/$category/$code');

      final response = await http.get(url);
      if (response.statusCode == 200) {
        foods.value = foodsModelFromJson(response.body);
        apiError.value = null; // Clear previous errors
      } else {
        apiError.value = apiErrorFromJson(response.body);
        foods.value = null; // Clear previous data
      }
    } catch (err) {
      error.value = err as Exception?;
      apiError.value = null; // Clear previous errors
      foods.value = null; // Clear previous data
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    // Return a cleanup function if needed
    return null;
  }, [category, code]); // Add dependencies here

  void refetch() {
    fetchData();
  }

  return FetchHook(
      data: foods.value, isLoading: isLoading.value, error: error.value, reFetch: refetch);
}
