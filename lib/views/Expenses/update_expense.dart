import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/Expenses/update_expense_controller.dart';
import '../../models/expense.dart';

class UpdateExpenseScreen extends StatelessWidget {
  final ExpenseModel expense;
  final controller = Get.put(UpdateExpenseController());
  UpdateExpenseScreen({super.key, required this.expense}) {
    controller.expAmountCtr.text = expense.amount.toString();
    controller.expCatCtr.text = expense.category;
    controller.expForCtr.text = expense.expense;
    controller.expenseDateCtr.text =
        DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(expense.date);
    controller.expNoteCtr.text = expense.note!;
    controller.expCatCtr.text = expense.category;
    controller.expPaymentFor.value = expense.paymentMethod;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Expense"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.deleteExpense(expense.id!);
            },
            icon: Icon(Icons.delete, color: Colors.red[800]),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    controller: controller.expenseDateCtr,
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (selectedDate != null) {
                        controller.expenseDateCtr.text =
                            DateFormat('yyyy-MM-ddTHH:mm:ssZ')
                                .format(selectedDate);
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Expense Date',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: Icon(Icons.date_range),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter date';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    controller: controller.expCatCtr,
                    onTap: () async {
                      controller.openCategoryList();
                    },
                    decoration: const InputDecoration(
                      labelText: 'Expense Category',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: Icon(Icons.category),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter category';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller.expForCtr,
                    decoration: const InputDecoration(
                      labelText: 'Expense For',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter expense for';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller.expAmountCtr,
                    onChanged: (value) {},
                    onFieldSubmitted: (value) {},
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Expense Amount",
                      border: const OutlineInputBorder(),
                      suffixIcon: Obx(() => DropdownButton<String>(
                            hint: const Text("Payment type"),
                            value: controller.expPaymentFor.value.isEmpty
                                ? null
                                : controller.expPaymentFor.value,
                            onChanged: (String? newValue) {
                              controller.changeCategory(newValue!);
                            },
                            items: <String>['Cash', 'Bank', 'Card', 'Mobile']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            underline: Container(),
                          )),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter amount';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller.expNoteCtr,
                    minLines: 5,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      labelText: 'Notes',
                      hintText: '(Optional)',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Obx(
                  () => ElevatedButton(
                      onPressed: () {
                        controller.updateExpense(expense.id!);
                      },
                      child: Center(
                          child: controller.isUpdating.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator())
                              : const Text("Update Expense"))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
