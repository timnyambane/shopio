class ProductCategoryModel {
  String name;

  ProductCategoryModel({required this.name});

  Map<String, dynamic> toMap() {
    return {'name': name};
  }

  factory ProductCategoryModel.fromMap(Map<String, dynamic> map) {
    return ProductCategoryModel(name: map['name']);
  }
}
