import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../models/expense.dart';
import '../../utils/constants.dart';
import '../../views/Expenses/expense_category.dart';
import 'expenses_controller.dart';

class UpdateExpenseController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final expenseDateCtr = TextEditingController();
  final expCatCtr = TextEditingController();
  final expForCtr = TextEditingController();
  final expAmountCtr = TextEditingController();
  final expReferenceCtr = TextEditingController();
  final expNoteCtr = TextEditingController();

  final expPaymentFor = ''.obs;
  final isUpdating = false.obs;

  void changeCategory(String newValue) {
    expPaymentFor.value = newValue;
  }

  String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  Future<void> openCategoryList() async {
    final selectedCategory = await Get.to(() => ExpensesCategoryList());
    if (selectedCategory != null) {
      expCatCtr.text = selectedCategory;
    }
  }

  Future<void> updateExpense(int expenseId) async {
    if (formKey.currentState!.validate()) {
      isUpdating.value = true;

      try {
        final expense = ExpenseModel(
            id: expenseId,
            expense: capitalize(expForCtr.text),
            amount: double.parse(expAmountCtr.text),
            category: expCatCtr.text,
            date: DateTime.parse(expenseDateCtr.text),
            paymentMethod: expPaymentFor.value,
            note: expNoteCtr.text);

        final response = await http.patch(
            Uri.parse('${Constants.expensesEndpoint}/$expenseId/'),
            body: expense.toMap());

        if (response.statusCode == 200) {
          final partiesController = Get.find<ExpensesController>();
          partiesController.fetchExpenses();

          expAmountCtr.clear();
          expNoteCtr.clear();
          expCatCtr.clear();
          expPaymentFor.value = '';
          expenseDateCtr.clear();
          expCatCtr.clear();
          expForCtr.clear();

          isUpdating.value = false;
          Fluttertoast.showToast(
              msg: 'Succesfully updated the expense',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white);
          Get.back();
        } else {
          Fluttertoast.showToast(
              msg:
                  'Failed to update expense. Status code: ${response.statusCode}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white);
          isUpdating.value = false;
        }
      } catch (e) {
        Fluttertoast.showToast(
            msg: 'Error updating expense: $e',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white);
        isUpdating.value = false;
      }
    }
  }

  Future<void> deleteExpense(int expenseId) async {
    bool confirmed = await showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Confirm Deletion'),
              content:
                  const Text('Are you sure you want to delete this expense?'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Delete'))
              ]);
        });
    if (confirmed) {
      try {
        final response = await http
            .delete(Uri.parse('${Constants.partiesEndpoint}/$expenseId/'));

        if (response.statusCode == 204) {
          final expenseController = Get.find<ExpensesController>();
          expenseController.fetchExpenses();

          Fluttertoast.showToast(
            msg: 'Successfully deleted the expense',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          Get.back();
        } else {
          Fluttertoast.showToast(
            msg:
                'Failed to delete expense. Status code: ${response.statusCode}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Error deleting expense: $e',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
  }
}
