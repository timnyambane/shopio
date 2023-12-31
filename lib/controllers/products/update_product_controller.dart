import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../models/product.dart';
import '../../utils/constants.dart';
import '../../views/Products/product_category_list.dart';
import 'products_controller.dart';

class UpdateProductController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameCtr = TextEditingController();
  final pCodeCtr = TextEditingController();
  final stockCtr = TextEditingController();
  final pPriceCtr = TextEditingController();
  final sPriceCtr = TextEditingController();
  final prodCat = TextEditingController();

  var units = ("").obs;
  final isUpdating = false.obs;
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

  void updateProduct(String productId) async {
    if (formKey.currentState!.validate()) {
      isUpdating.value = true;

      try {
        final product = ProductModel(
            id: int.parse(''),
            name: capitalize(nameCtr.text),
            productCode: pCodeCtr.text,
            stock: int.parse(stockCtr.text),
            purchasePrice: double.parse(pPriceCtr.text),
            sellingPrice: double.parse(sPriceCtr.text),
            category: prodCat.text,
            units: units.value);

        final response = await http.patch(
            Uri.parse('${Constants.productsEndpoint}/$productId/'),
            body: product.toMap());

        if (response.statusCode == 200) {
          final productController = Get.find<ProductsController>();
          productController.fetchProducts();

          nameCtr.clear();
          pCodeCtr.clear();
          stockCtr.clear();
          pCodeCtr.clear();
          sPriceCtr.clear();
          prodCat.clear();
          units.value = '';

          isUpdating.value = false;
          Fluttertoast.showToast(
              msg: 'Succesfully updated the product',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white);
          Get.back();
        } else {
          Fluttertoast.showToast(
              msg:
                  'Failed to update product. Status code: ${response.statusCode}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white);
          isUpdating.value = false;
        }
      } catch (e) {
        Fluttertoast.showToast(
            msg: 'Error updating product: $e',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white);
        isUpdating.value = false;
      }
    }
  }

  Future<void> deleteProduct(int productId) async {
    bool confirmed = await showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Confirm Deletion"),
              content:
                  const Text("Are you sure you want to delete this product"),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text("Delete"))
              ]);
        });

    if (confirmed) {
      try {
        final response = await http
            .delete(Uri.parse('${Constants.productsEndpoint}/$productId/'));

        if (response.statusCode == 204) {
          final productController = Get.find<ProductsController>();
          productController.fetchProducts();

          Fluttertoast.showToast(
            msg: 'Successfully deleted the product',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          Get.back();
        } else {
          Fluttertoast.showToast(
            msg:
                'Failed to delete product. Status code: ${response.statusCode}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Error deleting product: $e',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
  }
}
