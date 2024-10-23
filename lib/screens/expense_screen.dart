import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseScreen extends StatefulWidget {
  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  Future<void> addExpense() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double totalExpenses = prefs.getDouble('expenses') ?? 0;
    prefs.setDouble('expenses', totalExpenses + double.parse(amountController.text));
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
