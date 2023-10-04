import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExpenseController extends GetxController {
  final expenseCtr = TextEditingController();
  final expCatCtr = TextEditingController();
  final expForCtr = TextEditingController();
  final expAmountCtr = TextEditingController();
  final expReferenceCtr = TextEditingController();
  final expNoteCtr = TextEditingController();

  final expCategory = ''.obs;

  void changeCategory(String newValue) {
    expCategory.value = newValue;
  }

  @override
  void onClose() {
    expenseCtr.dispose();
    super.onClose();
  }
}
