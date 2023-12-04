import 'package:get/get.dart';

class CleanCartController extends GetxController {
  RxMap<String, dynamic> cartItems = <String, dynamic>{}.obs;
  RxDouble netPay = 0.0.obs;
  Map<String, dynamic>? currentProductDetails;
  RxInt cartItemCount = 0.obs;
  void addToCart(Map<String, dynamic> productDetails) {
    String productId = productDetails['id'].toString();
    currentProductDetails = productDetails;
    if (cartItems.containsKey(productId)) {
      cartItems[productId] = productDetails;
    } else {
      cartItems[productId] = productDetails;
      cartItems.update('${productDetails['id'].toString()}',
          (existingValue) => productDetails,
          ifAbsent: () => productDetails);
    }
    int count = currentProductDetails?['buttonCount'];
    double price = currentProductDetails?['price'] / 1.0;
    cartItemCount.value += count;
    netPay.value += count * price / 1.0;
    print("Cart Items: ${cartItems.length}${cartItems.value}");
  }

  int get cartCount => cartItems.length;
}
