import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../controllers/Products/add_product_controller.dart';
import 'category_list.dart';

class AddProductScreen extends StatelessWidget {
  final controller = Get.put(AddProductController());

  AddProductScreen({super.key});

  Future<void> openCategoryList() async {
    final selectedCategory = await Get.to(() => CategoryList());
    if (selectedCategory != null) {
      controller.prodCat.text = selectedCategory;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller.nameCtr,
                    decoration: const InputDecoration(
                      labelText: 'Product Name',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter product name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    controller: controller.prodCat,
                    onTap: () async {
                      openCategoryList();
                    },
                    decoration: const InputDecoration(
                      labelText: 'Product Category',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: Icon(Icons.category),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please select product category';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller.stockCtr,
                    onChanged: (value) {},
                    onFieldSubmitted: (value) {},
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Stock Count",
                      border: const OutlineInputBorder(),
                      suffixIcon: Obx(() => DropdownButton<String>(
                            hint: const Text("Choose units"),
                            value: controller.units.value.isEmpty
                                ? null
                                : controller.units.value,
                            onChanged: (String? newValue) {
                              controller.updateSelectedUnit(newValue!);
                            },
                            items: <String>[
                              'items',
                              'liters',
                              'kgs',
                              'packets',
                              'sacks',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            underline: Container(),
                          )),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter stock count';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller.pCodeCtr,
                    onChanged: (value) {},
                    onFieldSubmitted: (value) {},
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Product Code",
                      hintText: controller.promoCodeHint,
                      border: const OutlineInputBorder(),
                      suffixIcon: InkWell(
                          onTap: () => scanBarcodeNormal(),
                          child: const Icon(Icons.camera_alt)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter product code';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.pPriceCtr,
                          decoration: const InputDecoration(
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text('Sh.')],
                            ),
                            //hintText: 'Enter price',
                            labelText: 'Purchase Price',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter purchase price';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: TextFormField(
                          controller: controller.sPriceCtr,
                          decoration: const InputDecoration(
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text('Sh.')],
                            ),
                            labelText: 'Selling Price',
                            //hintText: 'Enter price',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter selling price';
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => ElevatedButton(
                          onPressed: () {
                            controller.submitProduct();
                          },
                          child: Center(
                              child: controller.isAdding.value
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(),
                                    )
                                  : const Text("Add"))),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (barcodeScanRes != '-1') {
      controller.pCodeCtr.text = barcodeScanRes;
    }
  }
}
