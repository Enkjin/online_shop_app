import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:online_shop_app/components/category_list_view.dart';
import 'package:online_shop_app/components/product_list_item.dart';
import 'package:online_shop_app/controller/cart_controller.dart';
import 'package:online_shop_app/pages/cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _MyTabbedListViewState createState() => _MyTabbedListViewState();
}

class _MyTabbedListViewState extends State<HomePage> {
  String selectedCategory = '';
  late PageController _pageController;
  List<String> categories = [];
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/categories'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<String> titles = data.map((item) => item.toString()).toList();
      setState(() {
        categories = titles;
      });
    } else {
      throw Exception('Failed to get titles');
    }
  }

  Future<List<Map<String, dynamic>>> fetchProductsForCategory(
      String category) async {
    try {
      final response = await http.get(
          Uri.parse('https://fakestoreapi.com/products/category/$category'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map<Map<String, dynamic>>((item) => {
                  'id': item['id'],
                  'title': item['title'],
                  'image': item['image'],
                  'price': item['price'],
                })
            .toList();
      } else {
        throw Exception('Failed to get data from category');
      }
    } catch (error) {
      print('Error fetching products for $category: $error');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mega mall",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
        ),
        centerTitle: true,
        actions: [
          GetBuilder<CartController>(
              init: CartController(),
              builder: (controller) => Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: IconButton(
                      icon: const Icon(
                        Icons.shopping_cart,
                        size: 36,
                        color: Colors.deepPurple,
                      ),
                      onPressed: () {
                        Get.to(() =>
                            const CartPage()); // Navigate to the cart page
                      },
                      tooltip: 'Cart (${controller.cartCount})',
                    ),
                  )),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 20.0, top: 20.0),
            child: Text('Categories',
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.w600, fontSize: 20.0)),
          ),
          //
          CategoryListView(
            categories: categories,
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
            child: Text(selectedCategory.toUpperCase(),
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.w600, fontSize: 20.0)),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchProductsForCategory(selectedCategory),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final products = snapshot.data ?? [];
                  print(products);
                  return ProductListItem(
                      products: products, title: selectedCategory);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
