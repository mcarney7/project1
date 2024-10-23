import 'package:flutter/material.dart';
import 'package:project1/services/db_helper.dart';

class IncomeScreen extends StatefulWidget {
  @override
  _IncomeScreenState createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<void> addIncome() async {
    Map<String, dynamic> income = {
      'source': sourceController.text,
      'amount': double.parse(amountController.text),
      'date': DateTime.now().toString(),
    };
    await dbHelper.insertIncome(income);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Income")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: sourceController, decoration: InputDecoration(labelText: 'Source')),
            TextField(controller: amountController, decoration: InputDecoration(labelText: 'Amount')),
            ElevatedButton(onPressed: addIncome, child: Text("Save Income")),
          ],
        ),
      ),
    );
  }
}
