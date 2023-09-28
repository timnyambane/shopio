import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsController extends GetxController {
  final loading = true.obs;
  final productsList = <Map<String, dynamic>>[].obs;
  final filteredProducts = <Map<String, dynamic>>[].obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    loading.value = true;
    try {
      final url = Uri.parse('https://jacmwas.pythonanywhere.com/products/');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        productsList.assignAll(responseData.cast<Map<String, dynamic>>());
        filterProducts('');
      } else {
        print('Failed to fetch products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      loading.value = false;
    }
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.assignAll(productsList);
    } else {
      filteredProducts.assignAll(productsList.where((product) {
        final name = product['name'] ?? '';
        return name.toLowerCase().contains(query.toLowerCase());
      }).toList());
    }
  }
}