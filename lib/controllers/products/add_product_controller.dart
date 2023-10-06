import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/product.dart';
import '../../utils/constants.dart';
import '../../views/Products/product_category_list.dart';
import 'products_controller.dart';

class AddProductController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameCtr = TextEditingController();
  final pCodeCtr = TextEditingController();
  final stockCtr = TextEditingController();
  final pPriceCtr = TextEditingController();
  final sPriceCtr = TextEditingController();
  final prodCat = TextEditingController();

  var units = ("").obs;
  final isAdding = false.obs;
  String prodCodeHint = 'Enter Product Code';

  String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  void updateSelectedUnit(String item) {
    units.value = item;
  }

  Future<void> openCategoryList() async {
    final selectedCategory = await Get.to(() => ProductCategoryList());
    if (selectedCategory != null) {
      prodCat.text = selectedCategory;
    }
  }

  void submitProduct() async {
    if (formKey.currentState!.validate()) {
      if (units.value == '') {
        Get.snackbar("Warning", "Please select units",
            backgroundColor: Colors.amber[200],
            colorText: Colors.black,
            icon: const Icon(Icons.info));
      } else {
        isAdding.value = true;
        final product = ProductModel(
          name: capitalize(nameCtr.text),
          category: prodCat.text,
          stock: int.parse(stockCtr.text),
          units: units.value,
          productCode: pCodeCtr.text,
          purchasePrice: double.parse(pPriceCtr.text),
          sellingPrice: double.parse(sPriceCtr.text),
        );
        try {
          final response = await http.post(
              Uri.parse(Constants.productsEndpoint),
              headers: {'Content-Type': 'application/json'},
              body: json.encode(product.toMap()));

          if (response.statusCode == 201) {
            isAdding.value = false;
            Fluttertoast.showToast(
              msg: "Added product successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );

            final productController = Get.find<ProductsController>();
            productController.fetchProducts();

            nameCtr.clear();
            pCodeCtr.clear();
            stockCtr.clear();
            units.value = '';
            pCodeCtr.clear();
            pPriceCtr.clear();
            sPriceCtr.clear();
            prodCat.clear();

            Get.back();
          } else {
            Fluttertoast.showToast(
              msg:
                  'Failed to create product. Status code: ${response.statusCode}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
            isAdding.value = false;
          }
        } catch (e) {
          Fluttertoast.showToast(
            msg: 'Error creating product: $e',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          isAdding.value = false;
        }
      }
    }
  }

  @override
  void onClose() {
    nameCtr.dispose();
    stockCtr.dispose();
    pCodeCtr.dispose();
    pPriceCtr.dispose();
    sPriceCtr.dispose();
    super.onClose();
  }
}
