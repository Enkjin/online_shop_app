import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CleanHomeController extends GetxController {
  RxList<String> titles = <String>[].obs;
  RxList<Map<String, dynamic>> allProducts = <Map<String, dynamic>>[].obs;

  RxBool loading = false.obs;

  String currentCategory = '';

  @override
  onInit() {
    super.onInit();
    fetchCategories();

    loading.value = true;
    fetchProductsForCategory(currentCategory);
    loading.value = false;
  }

  Future<void> fetchCategories() async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/categories'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      titles.value = data.map((item) => item.toString()).toList();
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
        allProducts.value = data
            .map<Map<String, dynamic>>((item) => {
                  'id': item['id'],
                  'title': item['title'],
                  'image': item['image'],
                  'price': item['price'],
                })
            .toList();
        return allProducts;
      } else {
        throw Exception('Failed to get data from category');
      }
    } catch (error) {
      print('Error fetching products for $category: $error');
      return [];
    }
  }

  String get getCurrentCategory {
    return currentCategory;
  }
}
