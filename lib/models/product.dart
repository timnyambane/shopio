class Product {
  String name, category, units, pCode, stock, pPrice, sPrice;

  Product(
      {required this.name,
      required this.category,
      required this.stock,
      required this.units,
      required this.pCode,
      required this.pPrice,
      required this.sPrice});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'stock': stock,
      'units': units,
      'pCode': pCode,
      'pPrice': pPrice,
      'sPrice': sPrice,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'],
      category: map['category'],
      stock: map['stock'],
      units: map['units'],
      pCode: map['pCode'],
      pPrice: map['pPrice'],
      sPrice: map['sPrice'],
    );
  }
}
