import 'package:get/get.dart';

class CleanCartController extends GetxController {
  RxMap<String, dynamic> cartItems = <String, dynamic>{}.obs;
  Map<String, dynamic>? currentProductDetails;
  void addToCart(Map<String, dynamic> productDetails) {
    String productId = productDetails['id'].toString();
    // Check if the product already exists in the cart
    if (cartItems.containsKey(productId)) {
      currentProductDetails = productDetails;
      // If so, update its details (this might include updating quantity, etc.)
      cartItems[productId] =
          productDetails; // or some logic to update the existing item
    } else {
      // If not, add the new product
      cartItems[productId] = productDetails;
      cartItems.update('${productDetails['id'].toString()}',
          (existingValue) => productDetails,
          ifAbsent: () => productDetails);
    }
    print("Cart Items: ${cartItems.length}${cartItems.value}");
  }

  int get cartCount => cartItems.length;
  double get calculatedNetPay {
    if (currentProductDetails == 0) {
      return 0.0;
    } else {
      int count = currentProductDetails?['buttonCount'];
      double price = currentProductDetails?['price'] / 1.0;

      return count * price / 1.0;
    }
  }
}
