



import 'package:get/get.dart';
import 'package:online_shop_app/clean/home/clean_home_controller.dart';

class CleanHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CleanHomeController());
  }

}