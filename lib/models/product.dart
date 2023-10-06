class ProductModel {
  int? id;
  int stock;
  String name, category, units, productCode;
  double purchasePrice, sellingPrice;

  ProductModel(
      {this.id,
      required this.name,
      required this.category,
      required this.stock,
      required this.units,
      required this.productCode,
      required this.purchasePrice,
      required this.sellingPrice});

  Map<String, dynamic> toMap() {
    return {
      'id': id?.toString(),
      'name': name,
      'category': category,
      'stock': stock.toString(),
      'units': units,
      'product_code': productCode,
      'purchase_price': purchasePrice.toString(),
      'selling_price': sellingPrice.toString(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      stock: map['stock'],
      units: map['units'],
      productCode: map['product_code'],
      purchasePrice: map['purchase_price'],
      sellingPrice: map['selling_price'],
    );
  }
}
