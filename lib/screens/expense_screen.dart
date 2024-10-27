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
    if (descriptionController.text.isNotEmpty && amountController.text.isNotEmpty) {
      Map<String, dynamic> expense = {
        'description': descriptionController.text,
        'amount': double.parse(amountController.text),
        'date': DateTime.now().toString(),
      };
      await dbHelper.insertExpense(expense);
      descriptionController.clear();
      amountController.clear();
      Navigator.pop(context);
    } else {
      setState(() {
        errorMessage = "Please fill in all fields.";
      });
    }
  }

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expense"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add New Expense",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pink[900]),
            ),
            SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Expense Description',
                prefixIcon: Icon(Icons.description, color: Colors.pink),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                prefixIcon: Icon(Icons.money_off, color: Colors.pink),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addExpense,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink, // Updated to use backgroundColor and changed to pink
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                "Save Expense",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
