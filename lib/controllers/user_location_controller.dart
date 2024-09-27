import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/constants.dart';

class UserLocationController extends GetxController {
  LatLng position = const LatLng(0, 0);

  void setPosition(LatLng pos) {
    position = pos;
    update();
  }

  final RxString _address = "".obs;
  String get address => _address.value;

  void setAddress(String add) {
    _address.value = add;
  }

  final RxString _postalCode = "".obs;
  String get postalCode => _postalCode.value;

  void setPostalCode(String code) => _postalCode.value = code;

  Future<void> getUserAddress(LatLng position) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleApi');

    try {
      final response = await http.get(url);
      print(response.statusCode);
      print(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data['status']);

        if (data['status'] == 'OK') {
          final results = data['results'][0];
          final formattedAddress = results['formatted_address'];
          final postalCode = results['address_components'].firstWhere(
              (component) => component['types'].contains('postal_code'),
              orElse: () => {'long_name': 'N/A'})['long_name'];

          setAddress(formattedAddress);
          setPostalCode(postalCode);
        } else {
          print('Failed to get address: ${data['status']}');
        }
      } else {
        print('Failed to connect to the API: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }
}
