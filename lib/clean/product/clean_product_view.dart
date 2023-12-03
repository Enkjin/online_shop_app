import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shop_app/clean/cart/clean_cart_controller.dart';
import 'package:online_shop_app/clean/product/clean_product_controller.dart';

class CleanProductView extends GetView<CleanProductController> {
  const CleanProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.fetchProductDetails(controller.productId.value);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mega mall",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
        ),
        centerTitle: true,
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
                Get.put(CleanCartController(), permanent: true);
                final cleancartcontroller = Get.find<CleanCartController>();
                Get.toNamed('/cart');
              },
            ),
          )
        ],
      ),
      body: Obx(() {
        if (controller.productDetails.value.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final product = controller.productDetails.value;
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network(
                  product['image'],
                  height: 300.0,
                  width: 325.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product['title'],
                      style: GoogleFonts.lato(
                          fontSize: 25.0, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '\$${product['price']}',
                      style:
                          GoogleFonts.lato(color: Colors.red, fontSize: 25.0),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                      child: Text(
                        'Description Product ',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      product['description'],
                      style: GoogleFonts.lato(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      persistentFooterButtons: [
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: controller.decrementButtonCount,
                ),
                Text(
                  '${controller.buttonCount}',
                  style: GoogleFonts.lato(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: controller.incrementButtonCount,
                ),
                Text(
                  '\$${controller.totalPrice}',
                  style: GoogleFonts.lato(color: Colors.red),
                ),
                const SizedBox(width: 20),
                FilledButton(
                    onPressed: () {
                      Get.put(CleanCartController(), permanent: true);
                      final cleancartcontroller =
                          Get.find<CleanCartController>();
                      controller.productDetails.value['buttonCount'] =
                          controller.buttonCount.value;
                      print('buttoncountis${controller.buttonCount.value}');
                      cleancartcontroller
                          .addToCart(controller.productDetails.value);
                      controller.buttonCount.value = 0;
                      controller.totalPrice.value = 0.0;
                      controller.isTextshown.value =
                          !controller.isTextshown.value;
                    },
                    child: controller.isTextshown.value
                        ? Text(
                            'Add to cart',
                            style: GoogleFonts.lato(fontSize: 16),
                          )
                        : const Icon(Icons.done))
              ],
            )),
      ],
    );
  }
}
