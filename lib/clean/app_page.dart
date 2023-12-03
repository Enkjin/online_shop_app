import 'package:get/route_manager.dart';
import 'package:online_shop_app/clean/cart/clean_cart_binding.dart';
import 'package:online_shop_app/clean/cart/clean_cart_view.dart';
import 'package:online_shop_app/clean/home/clean_home_binding.dart';
import 'package:online_shop_app/clean/home/clean_home_view.dart';
import 'package:online_shop_app/clean/product/clean_product_binding.dart';
import 'package:online_shop_app/clean/product/clean_product_view.dart';

class AppPage {
  static const initialRoute = '/';

  static List<GetPage> pages = [
    GetPage(
        name: '/',
        page: () => const CleanHomeView(),
        binding: CleanHomeBinding()),
    GetPage(
        name: '/cart',
        page: () => const CleanCartView(),
        binding: CleanCartBinding()),
    GetPage(
        name: '/product',
        page: () => CleanProductView(),
        binding: ClearProductBinding())
  ];
}
