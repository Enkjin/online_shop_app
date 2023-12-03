import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shop_app/clean/home/clean_home_controller.dart';
import 'package:online_shop_app/components/category_list_view.dart';
import 'package:online_shop_app/components/product_item.dart';
import 'package:online_shop_app/components/product_list_item.dart';

class CleanHomeView extends GetView<CleanHomeController> {
  const CleanHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Clean mall',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 36,
                  color: Colors.deepPurple,
                ),
                onPressed: () {
                  Get.toNamed('/cart'); // Navigate to the cart page
                },
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Obx(() {
              return CategoryListView(
                categories: controller.titles.value,
                onCategorySelected: (category) {
                  controller.currentCategory = category;
                  controller.fetchProductsForCategory(category);
                },
              );
            }),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
              child: Text(controller.currentCategory.toUpperCase(),
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.w600, fontSize: 20.0)),
            ),
            Expanded(
              child: Obx(() {
                if (controller.loading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: controller.allProducts.length,
                    itemBuilder: (context, index) {
                      final product = controller.allProducts[index];

                      return ProductItem(
                        id: product['id'],
                        title: product['title'],
                        src: product['image'],
                        price: product['price']
                            .toDouble(), // Make sure to convert price to double
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ));
  }
}
