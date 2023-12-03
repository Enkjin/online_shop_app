import 'package:get/get.dart';
import 'package:online_shop_app/clean/product/clean_product_controller.dart';

class ClearProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CleanProductController());
  }
}
