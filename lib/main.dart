import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:online_shop_app/clean/app_page.dart';
import 'package:online_shop_app/clean/cart/clean_cart_controller.dart';
import 'package:online_shop_app/clean/home/clean_home_controller.dart';
import 'package:online_shop_app/clean/product/clean_product_controller.dart';

void main() {
  Get.put(CleanCartController());
  // Get.put(CleanHomeController());
  // Get.put(CleanProductController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppPage.initialRoute,
      getPages: AppPage.pages,
    );
  }
}
