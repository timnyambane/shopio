import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shopio/models/product.dart';

import '../../utils/constants.dart';
import '../../views/Products/category_list.dart';

class AddProductController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameCtr = TextEditingController();
  final pCodeCtr = TextEditingController();
  final stockCtr = TextEditingController();
  final pPriceCtr = TextEditingController();
  final sPriceCtr = TextEditingController();
  final prodCat = TextEditingController();

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

  Future<void> openCategoryList() async {
    final selectedCategory = await Get.to(() => CategoryList());
    if (selectedCategory != null) {
      prodCat.text = selectedCategory;
    }
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
          final product = Product(
              name: capitalize(nameCtr.text),
              category: productCategory.value,
              stock: stockCtr.text,
              units: units.value,
              pCode: pCodeCtr.text,
              pPrice: double.parse(pPriceCtr.text),
              sPrice: double.parse(sPriceCtr.text));

          final response = await http.post(
              Uri.parse(Constants.productsEndpoint),
              body: {product.toMap()});

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
            Fluttertoast.showToast(
                msg: "Added product succesfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                backgroundColor: Colors.green,
                textColor: Colors.white);
            Get.back();
          } else {
            Fluttertoast.showToast(
                msg:
                    'Failed to create product. Status code: ${response.statusCode}',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                backgroundColor: Colors.red,
                textColor: Colors.white);
            isAdding.value = false;
          }
        } catch (e) {
          Fluttertoast.showToast(
              msg: 'Error creating party: $e',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.red,
              textColor: Colors.white);
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
