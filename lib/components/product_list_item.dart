import 'package:flutter/material.dart';
import 'package:online_shop_app/components/product_item.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem(
      {super.key, required this.products, required this.title});
  final List<Map<String, dynamic>> products;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, itemIndex) {
        // pri
        final product = products[itemIndex];
        return ProductItem(
          id: product['id'],
          title: product['title'],
          src: product['image'],
          price: product['price'] / 1.0,
        );
      },
    );
  }
}
