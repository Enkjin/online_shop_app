import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shop_app/clean/cart/clean_cart_controller.dart';
import 'package:online_shop_app/clean/home/clean_home_controller.dart';
import 'package:online_shop_app/components/category_list_view.dart';
import 'package:online_shop_app/components/product_item.dart';

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
              child: InkWell(
                onTap: () {
                  Get.toNamed('/cart'); // Navigate to the cart page
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    const Icon(
                      Icons.shopping_cart,
                      size: 36,
                      color: Colors.deepPurple,
                    ),
                    // Use Obx to reactively update the item count
                    Obx(() {
                      final cartController = Get.find<CleanCartController>();
                      var itemCount = cartController
                          .cartItemCount.value; // Get the current item count
                      return itemCount > 0
                          ? Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                itemCount.toString(), // Display the item count
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Container(); // Empty container when there are no items
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Obx(() {
              return CategoryListView(
                categories: controller.titles.value,
                onCategorySelected: (category) {
                  controller.currentCategory.value = category;
                  controller.loading.value = true;
                  controller.updateCurrentCategory(category);
                  controller.fetchProductsForCategory(category).then((_) {
                    controller.loading.value =
                        false; // Set loading to false after fetching
                  });
                },
                selectedCategoryTitle: controller.currentCategory.value,
              );
            }),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                child: Text(controller.currentCategory.value.toUpperCase(),
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.w600, fontSize: 20.0)),
              );
            }),
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
