import 'package:get/get.dart';

class CategoryController extends GetxController {
  RxString _category = ''.obs;

  String get category => _category.value;

  set updateCategory(String cat) => _category.value = cat;

  RxString _title = ''.obs;

  set updateTitle(String title) => _title.value = title;

  String get title => _title.value;
}
