import 'package:get/get.dart';

class PasswordController extends GetxController {
  final RxBool _obscureText = true.obs;
  bool get obscureText => _obscureText.value;
  void toggleObscureText() => _obscureText.value = !_obscureText.value;
}
