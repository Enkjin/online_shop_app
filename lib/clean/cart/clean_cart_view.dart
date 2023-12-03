import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_shop_app/clean/cart/clean_cart_controller.dart';
import 'package:online_shop_app/components/cart_product_item.dart';

class CleanCartView extends GetView<CleanCartController> {
  const CleanCartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: controller.cartCount,
                  itemBuilder: (context, index) {
                    final product =
                        controller.cartItems.values.elementAt(index);
                    // final double netPay = controller.calculatedNetPay;

                    return Column(
                      children: <Widget>[
                        CartProductItem(
                          id: product['id'],
                          title: product['title'],
                          src: product['image'],
                          price: product['price'] / 1.0,
                          count: product['buttonCount'],
                        ),
                      ],
                    );
                  })),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              height: 50,
              child: FilledButton(
                onPressed: () {},
                child: Text('Pay \$${controller.calculatedNetPay}'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
