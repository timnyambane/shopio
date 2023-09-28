import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class AddProductController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameCtr = TextEditingController();
  final pCodeCtr = TextEditingController();
  final stockCtr = TextEditingController();
  final pPriceCtr = TextEditingController();
  final sPriceCtr = TextEditingController();

  final productCategory = RxString("Select category");
  var units = RxString("");
  final isAdding = false.obs;

  String promoCodeHint = 'Enter Product Code';
  List<String> codeList = [];

  String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  void updateSelectedUnit(String item) {
    units.value = item;
  }

  void submitProduct() async {
    if (formKey.currentState!.validate()) {
      if (productCategory.value == 'Select category') {
        Get.snackbar("Warning", "Please select category");
      } else if (units.value == '') {
        Get.snackbar("Warning", "Please select units");
      } else {
        isAdding.value = true;
        try {
          final url = Uri.parse(Constants.productsEndpoint);
          final response = await http.post(url, body: {
            'name': capitalize(nameCtr.text),
            'category': productCategory.value,
            'stock': stockCtr.text,
            'units': units.value,
            'product_code': pCodeCtr.text,
            'purchase_price': pPriceCtr.text,
            'selling_price': sPriceCtr.text
          });

          if (response.statusCode == 201) {
            nameCtr.clear();
            productCategory.value = 'Select category';
            pCodeCtr.clear();
            stockCtr.clear();
            units.value = '';
            pCodeCtr.clear();
            pPriceCtr.clear();
            sPriceCtr.clear();

            isAdding.value = false;
            print("Success");
            Get.back();
          } else {
            print(
                'Failed to create product. Status code: ${response.statusCode}');
            isAdding.value = false;
          }
        } catch (e) {
          print('Error creating party: $e');
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
