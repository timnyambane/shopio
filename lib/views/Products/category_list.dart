import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shopio/utils/constants.dart';

class CategoryController extends GetxController {
  final RxList<String> categories = <String>[].obs;
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final url = Uri.parse('https://jacmwas.pythonanywhere.com/categories/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<String> fetchedCategories =
            data.map((item) => item['name'] as String).toList();
        categories.clear();
        categories.addAll(fetchedCategories);
        isLoading.value = false;
      } else {
        print(
            'Failed to fetch categories. Status code: ${response.statusCode}');
        isLoading.value = false;
      }
    } catch (e) {
      print('Error fetching categories: $e');
      isLoading.value = false;
    }
  }

  Future<void> addCategory(BuildContext context) async {
    final category = categoryController.text.trim();

    if (category.isNotEmpty) {
      final url = Uri.parse(Constants.categoriesEndpoint);
      try {
        final response = await http.post(
          url,
          body: json.encode({'name': category}),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 201) {
          categoryController.clear();
          fetchCategories();
          Get.back();
        } else {
          // Handle error
          print('Failed to add category. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error adding category: $e');
      }
    }
  }

  List<String> getFilteredCategories() {
    String searchText = searchController.text.toLowerCase();
    return categories
        .where((category) => category.toLowerCase().contains(searchText))
        .toList();
  }

  void selectCategory(String category) {
    Get.back(result: category);
  }
}

class CategoryList extends StatelessWidget {
  final CategoryController _controller = Get.put(CategoryController());

  CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller.searchController,
                    onChanged: (_) {
                      // No need for setState in GetX
                    },
                    decoration: const InputDecoration(
                      hintText: "Search categories",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    _showAddCategoryDialog(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Obx(
              () {
                if (_controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (_controller.categories.isEmpty) {
                  return const Center(child: Text('No categories'));
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: _controller.getFilteredCategories().length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.category),
                            title: Text(
                              _controller.getFilteredCategories()[index],
                            ),
                            onTap: () {
                              _controller.selectCategory(
                                  _controller.getFilteredCategories()[index]);
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddCategoryDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a Category'),
          content: TextField(
            controller: _controller.categoryController,
            decoration: const InputDecoration(hintText: 'Enter a category'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (_controller.categoryController.text.isEmpty) {
                  Navigator.of(context).pop();
                } else {
                  _controller.addCategory(context);
                }
              },
            ),
          ],
        );
      },
    );
  }
}