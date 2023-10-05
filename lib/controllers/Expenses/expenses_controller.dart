import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpensesController extends GetxController {
  final fromCtr = TextEditingController();
  final toCtr = TextEditingController();
  final expensesList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> filteredExpenses = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    addExpense('Food', 'Lunch', DateTime(2023, 10, 5), 550, 'Cash');
    addExpense('Transport', 'Bills', DateTime(2023, 6, 1), 100, 'Mobile');
    addExpense('Rent', 'Utilities', DateTime(2023, 6, 5), 250, 'Bank');
    addExpense('Groceries', 'Shopping', DateTime(2023, 7, 2), 75, 'Card');
    addExpense('Travel', 'Vacation', DateTime(2023, 7, 10), 500, 'Cash');
    addExpense('Entertainment', 'Movies', DateTime(2023, 9, 3), 20, 'Mobile');
    addExpense('Utilities', 'Electricity', DateTime(2023, 9, 4), 80, 'Bank');
    addExpense('Healthcare', 'Doctor Visit', DateTime(2023, 5, 6), 120, 'Cash');
    addExpense('Clothing', 'Shopping', DateTime(2023, 10, 7), 50, 'Card');
    addExpense('Dining', 'Dinner', DateTime(2023, 10, 8), 30, 'Cash');
    addExpense('Education', 'Books', DateTime(2023, 10, 9), 60, 'Mobile');
    addExpense('Dining', 'Brunch', DateTime(2023, 5, 20), 35, 'Bank');
    addExpense('Shopping', 'Retail', DateTime(2023, 1, 15), 150, 'Card');
    addExpense('Entertainment', 'Movies', DateTime(2023, 9, 3), 20, 'Mobile');
    addExpense('Utilities', 'Electricity', DateTime(2023, 9, 4), 80, 'Bank');
    addExpense('Healthcare', 'Doctor Visit', DateTime(2023, 5, 6), 120, 'Cash');
    addExpense('Clothing', 'Shopping', DateTime(2023, 10, 7), 50, 'Card');
    addExpense('Dining', 'Dinner', DateTime(2023, 10, 8), 30, 'Cash');
    addExpense('Education', 'Books', DateTime(2023, 10, 9), 60, 'Mobile');
    addExpense('Dining', 'Brunch', DateTime(2023, 5, 20), 35, 'Bank');
    addExpense('Shopping', 'Retail', DateTime(2023, 1, 15), 150, 'Card');
    addExpense('Entertainment', 'Movies', DateTime(2023, 9, 3), 20, 'Mobile');
    addExpense('Utilities', 'Electricity', DateTime(2023, 9, 4), 80, 'Bank');
    addExpense('Healthcare', 'Doctor Visit', DateTime(2023, 5, 6), 120, 'Cash');
    addExpense('Clothing', 'Shopping', DateTime(2023, 10, 7), 50, 'Card');
    addExpense('Dining', 'Dinner', DateTime(2023, 10, 8), 30, 'Cash');
    addExpense('Education', 'Books', DateTime(2023, 10, 9), 60, 'Mobile');
    addExpense('Dining', 'Brunch', DateTime(2023, 5, 20), 35, 'Bank');
    addExpense('Shopping', 'Retail', DateTime(2023, 1, 15), 150, 'Card');
    addExpense('Entertainment', 'Movies', DateTime(2023, 9, 3), 20, 'Mobile');
    addExpense('Utilities', 'Electricity', DateTime(2023, 9, 4), 80, 'Bank');
    addExpense('Healthcare', 'Doctor Visit', DateTime(2023, 5, 6), 120, 'Cash');
    addExpense('Clothing', 'Shopping', DateTime(2023, 10, 7), 50, 'Card');
    addExpense('Dining', 'Dinner', DateTime(2023, 10, 8), 30, 'Cash');
    addExpense('Education', 'Books', DateTime(2023, 10, 9), 60, 'Mobile');
    addExpense('Dining', 'Brunch', DateTime(2023, 5, 20), 35, 'Bank');
    addExpense('Shopping', 'Retail', DateTime(2023, 1, 15), 150, 'Card');
    filterExpenses(DateTime(2000, 1, 1), DateTime.now());
  }

  double getTotalExpenses() {
    double total = 0;
    for (final expenseData in filteredExpenses) {
      total += expenseData['amount'];
    }
    return total;
  }

  void addExpense(String expense, String expCat, DateTime date, double amount,
      String paymentMethod) {
    expensesList.add({
      'expense': expense,
      'exp_cat': expCat,
      'date': date,
      'amount': amount,
      'payment_method': paymentMethod,
    });
  }

  void filterExpenses(DateTime fromDate, DateTime toDate) {
    filteredExpenses.assignAll(expensesList.where((expenseData) {
      final date = expenseData['date'] as DateTime;
      return date.isAfter(fromDate.subtract(const Duration(days: 1))) &&
          date.isBefore(toDate.add(const Duration(days: 1)));
    }).toList());
  }

  @override
  void onClose() {
    fromCtr.dispose();
    toCtr.dispose();
    super.onClose();
  }
}
