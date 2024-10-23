import 'package:flutter/material.dart';
import 'package:project1/services/db_helper.dart';

class ExpenseScreen extends StatefulWidget {
  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<void> addExpense() async {
    Map<String, dynamic> expense = {
      'description': descriptionController.text,
      'amount': double.parse(amountController.text),
      'date': DateTime.now().toString(),
    };
    await dbHelper.insertExpense(expense);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Expense")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: 'Description')),
            TextField(controller: amountController, decoration: InputDecoration(labelText: 'Amount')),
            ElevatedButton(onPressed: addExpense, child: Text("Save Expense")),
          ],
        ),
      ),
    );
  }
}
