import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/expense.dart';
import '../../utils/constants.dart';

class ExpensesController extends GetxController {
  final isLoading = true.obs;
  final expenses = <ExpenseModel>[].obs;
  final filteredExpenses = <ExpenseModel>[].obs;
  final fromCtr = TextEditingController();
  final toCtr = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchExpenses();
    filterExpenses(DateTime.parse('2000-01-01T00:00:00Z'), DateTime.now());
  }

  Future<void> fetchExpenses() async {
    isLoading.value = true;
    try {
      final url = Uri.parse(Constants.expensesEndpoint);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final List<ExpenseModel> expenseList = responseData
            .map((data) => ExpenseModel.fromMap(data as Map<String, dynamic>))
            .toList();

        expenses.assignAll(expenseList.toList());
        filterExpenses(DateTime(2000, 1, 1), DateTime.now());
      } else {
        Fluttertoast.showToast(
            msg:
                'Failed to fetch expenses. Status code: ${response.statusCode}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Error fetching expenses: $e',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  double getTotalExpenses() {
    double total = 0;
    for (final expenseData in filteredExpenses) {
      total += expenseData.amount;
    }
    return total;
  }

  void filterExpenses(DateTime fromDate, DateTime toDate) {
    filteredExpenses.assignAll(expenses.where((expenseData) {
      final date = expenseData.date;
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
