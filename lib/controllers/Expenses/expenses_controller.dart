import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpensesController extends GetxController {
  final fromCtr = TextEditingController();
  final toCtr = TextEditingController();
  final expensesList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    addExpense('Transport', 'Bills', DateTime(2023, 10, 1), 100);
    addExpense('Rent', 'Utilities', DateTime(2023, 10, 5), 250);
    addExpense('Food', 'Lunch', DateTime(2023, 10, 5), 550);
  }

  double getTotalExpenses() {
    double total = 0;
    for (final expenseData in expensesList) {
      total += expenseData['amount'];
    }
    return total;
  }

  void addExpense(String expense, String expCat, DateTime date, double amount) {
    expensesList.add({
      'expense': expense,
      'exp_cat': expCat,
      'date': date,
      'amount': amount,
    });
  }

  @override
  void onClose() {
    fromCtr.dispose();
    toCtr.dispose();
    super.onClose();
  }
}
