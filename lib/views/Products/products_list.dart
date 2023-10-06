import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import '../../controllers/Products/products_controller.dart';
import 'add_product.dart';
import 'update_product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  ProductsScreenState createState() => ProductsScreenState();
}

class ProductsScreenState extends State<ProductsScreen> {
  final controller = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(_createRoute());
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextField(
                      controller: controller.searchController,
                      onChanged: controller.filterProducts,
                      decoration: const InputDecoration(
                          hintText: 'Search Products...',
                          prefixIcon: Icon(Icons.search))),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: () => scanBarcodeNormal(),
                ),
              ],
            ),
          ),
          Obx(() {
            if (controller.loading.value) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (controller.filteredProducts.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: Text('No Products')),
              );
            } else {
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: controller.fetchProducts,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      itemCount: controller.filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = controller.filteredProducts[index];

                        return ListTile(
                            onTap: () {
                              Get.to(
                                  () => UpdateProductScreen(product: product));
                            },
                            visualDensity: VisualDensity.compact,
                            leading: const CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/prod_image.png")),
                            title: Text(product.name),
                            subtitle: Text("Sh. ${product.sellingPrice}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context).primaryColor,
                                )),
                            trailing:
                                Text("${product.stock} ${product.units}"));
                      },
                      separatorBuilder: (context, index) =>
                          const Divider(height: 0, thickness: 0),
                    ),
                  ),
                ),
              );
            }
          }),
        ],
      ),
    );
  }

  PageRouteBuilder _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          AddProductScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
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
      controller.searchController.text = barcodeScanRes;
      controller.filterProducts(barcodeScanRes);
    }
  }
}
