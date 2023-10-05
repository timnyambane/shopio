class ExpenseModel {
  int? id;
  String expense;
  String expCat;
  DateTime date;
  double amount;
  String paymentMethod;

  ExpenseModel({
    this.id,
    required this.expense,
    required this.amount,
    required this.date,
    required this.expCat,
    required this.paymentMethod,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'expense': expense,
      'exp_cat': expCat,
      'date': date.toIso8601String(),
      'amount': amount,
      'payment_method': paymentMethod,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      expense: map['expense'],
      expCat: map['exp_cat'],
      date: DateTime.parse(map['date']),
      amount: map['amount'],
      paymentMethod: map['payment_method'],
    );
  }
}
