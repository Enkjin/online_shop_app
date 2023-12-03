import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CleanProductController extends GetxController {
  Rx<Map<String, dynamic>> productDetails = Rx<Map<String, dynamic>>({});
  final RxInt buttonCount = 0.obs;
  final RxDouble totalPrice = 0.0.obs;
  RxInt productId = 0.obs;
  RxBool isTextshown = true.obs;

  void fetchProductDetails(int productId) async {
    try {
      final response = await http
          .get(Uri.parse('https://fakestoreapi.com/products/$productId'));
      if (response.statusCode == 200) {
        productDetails.value = jsonDecode(response.body);
      } else {
        throw Exception('Failed to get product details');
      }
    } catch (error) {
      print('Error fetching product details: $error');
    }
  }

  void setProductId(int id) {
    productId.value = id;
  }

  void incrementButtonCount() {
    buttonCount.value++;
    calculateTotalPrice();
  }

  void decrementButtonCount() {
    if (buttonCount.value > 0) {
      buttonCount.value--;
      calculateTotalPrice();
    }
  }

  void calculateTotalPrice() {
    double price = productDetails.value['price'] / 1.0;
    totalPrice.value = buttonCount.value.toDouble() * price;
  }
}
