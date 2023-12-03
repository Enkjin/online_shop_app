import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:online_shop_app/clean/cart/clean_cart_controller.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.productId});
  final int productId;

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetail> {
  int buttonCount = 0;
  double totalPrice = 0.0;
  bool isTextshown = true;
  Map<String, dynamic> productDetails = {};

  @override
  void initState() {
    super.initState();
    fetchProductDetails();
  }

  void fetchProductDetails() async {
    try {
      final response = await http.get(
          Uri.parse('https://fakestoreapi.com/products/${widget.productId}'));
      if (response.statusCode == 200) {
        productDetails = jsonDecode(response.body);
      } else {
        throw Exception('Failed to get product details');
      }
    } catch (error) {
      print('Error fetching product details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Mega mall",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
          centerTitle: true,
          actions: [
            GetBuilder<CleanCartController>(
                init: CleanCartController(),
                builder: (controller) => Padding(
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
                        tooltip: 'Cart (${controller.cartCount})',
                      ),
                    ))
          ]),
      body: Row(
        children: [
          Expanded(
            child: Builder(
              builder: (context) {
                try {
                  fetchProductDetails();
                  if (productDetails.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return SingleChildScrollView(
                    child: Column(
                      verticalDirection: VerticalDirection.down,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.network(
                            productDetails['image'],
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
                                '${productDetails['title']}',
                                style: GoogleFonts.lato(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '\$${productDetails['price']}',
                                style: GoogleFonts.lato(
                                    color: Colors.red, fontSize: 25.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 5.0),
                                child: Text(
                                  'Description Product ',
                                  style: GoogleFonts.lato(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                '${productDetails['description']}',
                                style: GoogleFonts.lato(fontSize: 16.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } catch (error) {
                  print('Error: $error');
                  return Center(child: Text('Error fetching product details'));
                }
              },
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
                icon: const Icon(size: 20, Icons.remove),
                onPressed: () {
                  setState(() {
                    if (buttonCount > 0) {
                      buttonCount--;
                      totalPrice =
                          buttonCount.toDouble() * productDetails['price'];
                    }
                  });
                }),
            SizedBox(
              height: 20.0,
              width: 20.0,
              child: Text(
                '$buttonCount',
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            IconButton(
                icon: const Icon(size: 20, Icons.add),
                onPressed: () {
                  setState(() {
                    buttonCount++;
                    if (!isTextshown) {
                      isTextshown = !isTextshown;
                    }
                    totalPrice =
                        buttonCount.toDouble() * productDetails['price'];
                  });
                }),
            Text(
              '\$$totalPrice',
              style: GoogleFonts.lato(color: Colors.red),
            ),
            const SizedBox(
              width: 20,
            ),
            FilledButton(
                onPressed: () {
                  Get.put(CleanCartController(), permanent: true);
                  final cleancartcontroller = Get.find<CleanCartController>();
                  productDetails['count'] = buttonCount;
                  cleancartcontroller.addToCart(productDetails);
                  setState(() {
                    isTextshown = !isTextshown;
                    buttonCount = 0;
                    totalPrice = 0;
                  });
                },
                child: isTextshown
                    ? Text(
                        'Add to cart',
                        style: GoogleFonts.lato(fontSize: 16),
                      )
                    : const Icon(Icons.done))
          ],
        ),
      ],
    );
  }
}
