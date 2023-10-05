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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  readOnly: true,
                  controller: controller.expenseCtr,
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate != null) {
                      controller.expenseCtr.text =
                          DateFormat('MMM d, y').format(selectedDate);
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Expense Date',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Icon(Icons.date_range),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  readOnly: true,
                  controller: controller.expCatCtr,
                  onTap: () async {},
                  decoration: const InputDecoration(
                    labelText: 'Expense Category',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Icon(Icons.category),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller.expForCtr,
                  decoration: const InputDecoration(
                    labelText: 'Expense For',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(),
                  ),
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
                          value: controller.expCategory.value.isEmpty
                              ? null
                              : controller.expCategory.value,
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
                      return 'Please enter stock count';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller.expNoteCtr,
                  minLines: 5,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const Center(child: Text("Add Expense")))
            ],
          ),
        ),
      ),
    );
  }
}
