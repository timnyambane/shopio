import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shopio/controllers/Expenses/add_expense_controller.dart';

class AddExpenseScreen extends StatelessWidget {
  final controller = Get.put(AddExpenseController());
  AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Expense"), centerTitle: true),
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
                        controller.submitExpense();
                      },
                      child: Center(
                          child: controller.isCreating.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator())
                              : const Text("Add Expense"))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
