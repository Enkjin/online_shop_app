import 'package:get/get.dart';

class CartController extends GetxController {
  RxMap<String, dynamic> cartItems = <String, dynamic>{}.obs;
  Map<String, dynamic>? currentProductDetails;
  void addToCart(Map<String, dynamic> productDetails) {
    cartItems[productDetails['id'].toString()] = productDetails;
    currentProductDetails = productDetails;
    update();
  }

  int get cartCount => cartItems.length;
  double get calculatedNetPay {
    double count = currentProductDetails?['count'] / 1.0;
    double price = currentProductDetails?['price'] / 1.0;

    return count * price;
  }
}
