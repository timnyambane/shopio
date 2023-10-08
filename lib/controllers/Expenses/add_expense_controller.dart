import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/expense.dart';
import '../../utils/constants.dart';
import '../../views/Expenses/expense_category.dart';
import 'expenses_controller.dart';

class AddExpenseController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final expenseDateCtr = TextEditingController();
  final expCatCtr = TextEditingController();
  final expForCtr = TextEditingController();
  final expAmountCtr = TextEditingController();
  final expReferenceCtr = TextEditingController();
  final expNoteCtr = TextEditingController();
  String originalDate = '';

  final expPaymentFor = ''.obs;
  final isCreating = false.obs;

  String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  void changeCategory(String newValue) {
    expPaymentFor.value = newValue;
  }

  Future<void> openCategoryList() async {
    final selectedCategory = await Get.to(() => ExpensesCategoryList());
    if (selectedCategory != null) {
      expCatCtr.text = selectedCategory;
    }
  }

  Future<void> submitExpense() async {
    if (formKey.currentState!.validate()) {
      if (expPaymentFor.value == '') {
        Get.snackbar("Warning", "Please select payment type",
            backgroundColor: Colors.amber[200],
            colorText: Colors.black,
            icon: const Icon(Icons.info));
      } else {
        isCreating.value = true;

        final expense = ExpenseModel(
            expense: capitalize(expForCtr.text),
            amount: double.parse(expAmountCtr.text),
            category: expCatCtr.text,
            date: DateTime.parse(expenseDateCtr.text),
            paymentMethod: expPaymentFor.value,
            note: expNoteCtr.text);

        try {
          final response = await http.post(
            Uri.parse(Constants.expensesEndpoint),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(expense.toMap()),
          );
          if (response.statusCode == 201) {
            isCreating.value = false;
            Fluttertoast.showToast(
              msg: "Added expense successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );

            final expenseController = Get.find<ExpensesController>();
            expenseController.fetchExpenses();

            expAmountCtr.clear();
            expCatCtr.clear();
            expForCtr.clear();
            expNoteCtr.clear();
            expPaymentFor.value = '';
            expenseDateCtr.clear();

            Get.back();
          } else {
            Fluttertoast.showToast(
              msg:
                  'Failed to create expense. Status code: ${response.statusCode}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
            isCreating.value = false;
          }
        } catch (e) {
          Fluttertoast.showToast(
            msg: 'Error creating expense: $e',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          isCreating.value = false;
        }
        //print(DateTime.parse(formattedDate));
      }
    }
  }

  @override
  void onClose() {
    expenseDateCtr.dispose();
    super.onClose();
  }
}
