import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/products_controller.dart';
import 'add_product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  ProductsScreenState createState() => ProductsScreenState();
}

class ProductsScreenState extends State<ProductsScreen> {
  final _controller = Get.put(ProductsController());

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
                      controller: _controller.searchController,
                      onChanged: _controller.filterProducts,
                      decoration: const InputDecoration(
                          hintText: 'Search Products...',
                          prefixIcon: Icon(Icons.search))),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Obx(() {
            if (_controller.loading.value) {
              return const Text("Loading products");
            } else if (_controller.filteredProducts.isEmpty) {
              return const Text('No Products');
            } else {
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: _controller.fetchProducts,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: _controller.filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = _controller.filteredProducts[index];
                        return Card(
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/prod_image.png"),
                            ),
                            title: Text(product['name']),
                            subtitle:
                                Text("${product['stock']} ${product['units']}"),
                            trailing: Text("Sh. ${product['selling_price']}"),
                          ),
                        );
                      },
                      // separatorBuilder: (context, index) =>
                      //     const Divider(height: 0, thickness: 0),
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
}
