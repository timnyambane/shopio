class Product {
  int? id;
  String name, category, units, stock, pCode;
  double pPrice, sPrice;

  Product(
      {this.id,
      required this.name,
      required this.category,
      required this.stock,
      required this.units,
      required this.pCode,
      required this.pPrice,
      required this.sPrice});

  Map<String, dynamic> toMap() {
    return {
      'id': id.toString(),
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
      id: map['id'],
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
