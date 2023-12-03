import 'package:get/get.dart';
import 'package:online_shop_app/clean/cart/clean_cart_controller.dart';

class CleanCartBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CleanCartController());
  }
}