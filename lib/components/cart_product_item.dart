import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shop_app/components/product_detail.dart';

class CartProductItem extends StatelessWidget {
  const CartProductItem(
      {super.key,
      required this.id,
      required this.title,
      required this.src,
      required this.price, required this.count});
  final int id;
  final double price;
  final String title;
  final String src;
  final int count;

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
      trailing:  Text(
        'x $count',
        style: GoogleFonts.lato(fontSize: 18.0),
        ),
      leading: Image.network(
        src,
        height: 100.0,
        width: 100.0,
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetail(productId: id),
            ));
      },
    );
  }
}
