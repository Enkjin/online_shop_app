
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:online_shop_app/clean/app_page.dart';
void main() {
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
