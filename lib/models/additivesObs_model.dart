import 'package:get/get.dart';

class AdditivesObs extends GetxController {
  final int id;
  final String title;
  final String price;
  RxBool isChecked;

  AdditivesObs({
    required this.id,
    required this.title,
    required this.price,
    required bool checked,
  }) : isChecked = RxBool(checked);

  void toggleChecked() {
    isChecked.value = !isChecked.value;
  }
}
