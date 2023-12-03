import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shop_app/clean/product/clean_product_controller.dart';
import 'package:online_shop_app/clean/product/clean_product_view.dart';
import 'package:online_shop_app/components/product_detail.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {super.key,
      required this.id,
      required this.title,
      required this.src,
      required this.price});
  final int id;
  final double price;
  final String title;
  final String src;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '$title',
        style: GoogleFonts.lato(fontWeight: FontWeight.w500, fontSize: 18.0),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      subtitle: Text(
        '\$$price',
        style: GoogleFonts.lato(color: Colors.red, fontSize: 18.0),
      ),
      trailing: const Icon(Icons.more_vert_rounded),
      leading: Image.network(
        src,
        height: 100.0,
        width: 100.0,
      ),
      onTap: () {
        Get.put(CleanProductController());
        Get.find<CleanProductController>().setProductId(id);
        Get.toNamed('/product');
      },
    );
  }
}
