import 'package:flutter/material.dart';
import 'package:project1/services/db_helper.dart';

class InvestmentScreen extends StatefulWidget {
  @override
  _InvestmentScreenState createState() => _InvestmentScreenState();
}

class _InvestmentScreenState extends State<InvestmentScreen> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<void> addInvestment() async {
    Map<String, dynamic> investment = {
      'description': descriptionController.text,
      'amount': double.parse(amountController.text),
      'date': DateTime.now().toString(),
    };
    await dbHelper.insertInvestment(investment);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Investment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: 'Description')),
            TextField(controller: amountController, decoration: InputDecoration(labelText: 'Amount')),
            ElevatedButton(onPressed: addInvestment, child: Text("Save Investment")),
          ],
        ),
      ),
    );
  }
}
