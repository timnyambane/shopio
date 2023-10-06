import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shopio/utils/constants.dart';

import '../../models/product.dart';

class ProductsController extends GetxController {
  final loading = true.obs;
  final products = <ProductModel>[].obs;
  final filteredProducts = <ProductModel>[].obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    loading.value = true;
    try {
      final url = Uri.parse(Constants.productsEndpoint);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final List<ProductModel> productsList = responseData
            .map((data) => ProductModel.fromMap(data as Map<String, dynamic>))
            .toList();
        products.assignAll(productsList.toList());
        filterProducts('');
      } else {
        Fluttertoast.showToast(
            msg:
                'Failed to fetch products. Status code: ${response.statusCode}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red,
            textColor: Colors.white);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Error fetching products: $e',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    } finally {
      loading.value = false;
    }
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.assignAll(products);
    } else {
      final lowerCaseQuery = query.toLowerCase();
      filteredProducts.assignAll(products.where((product) {
        final name = product.productCode.toLowerCase();
        final code = product.productCode.toLowerCase();

        return name.toLowerCase().contains(lowerCaseQuery) ||
            code.toLowerCase().contains(lowerCaseQuery);
      }).toList());
    }
  }
}
