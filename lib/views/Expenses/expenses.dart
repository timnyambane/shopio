import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/Expenses/expenses_controller.dart';
import 'add_expense.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExpensesController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(_createRoute());
              },
              icon: const Icon(Icons.post_add))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      controller: controller.fromCtr,
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if (selectedDate != null) {
                          controller.fromCtr.text =
                              DateFormat('MMM d, y').format(selectedDate);
                        }
                      },
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'From Date',
                        suffixIcon: Icon(Icons.date_range),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      controller: controller.toCtr,
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if (selectedDate != null) {
                          controller.toCtr.text =
                              DateFormat('MMM d, y').format(selectedDate);
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'To Date',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: Icon(Icons.date_range),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Expense",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Date",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Amount",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: controller.expensesList.length,
                    itemBuilder: (context, index) {
                      final expenseData = controller.expensesList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    expenseData['expense'].toString(),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    expenseData['exp_cat'].toString(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Text(
                                DateFormat('MMM d, y')
                                    .format(expenseData['date'] as DateTime),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                expenseData['amount'].toString(),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const Divider(height: 0, thickness: 0),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 54,
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Expenses:'),
              Text(
                "Sh. ${controller.getTotalExpenses()}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).primaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }

  PageRouteBuilder _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          AddExpenseScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
