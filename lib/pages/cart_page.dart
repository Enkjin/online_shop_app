import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_shop_app/components/cart_product_item.dart';
import 'package:online_shop_app/controller/cart_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: controller.cartItems.length,
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
                          count: product['count'],
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
