class ExpenseModel {
  int? id;
  String expense, category, paymentMethod;
  DateTime date;
  double amount;
  String? note;

  ExpenseModel(
      {this.id,
      required this.expense,
      required this.amount,
      required this.date,
      required this.category,
      required this.paymentMethod,
      this.note});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'expense': expense,
      'category': category,
      'date': date.toIso8601String(),
      'amount': amount,
      'payment_method': paymentMethod,
      'note': note
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      expense: map['expense'],
      category: map['category'],
      date: DateTime.parse(map['date']),
      amount: map['amount'].toDouble(),
      paymentMethod: map['payment_method'],
      note: map['note'],
    );
  }
}
