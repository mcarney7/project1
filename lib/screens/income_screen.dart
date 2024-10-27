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

  String errorMessage = '';

  Future<void> addIncome() async {
    if (sourceController.text.isNotEmpty && amountController.text.isNotEmpty) {
      Map<String, dynamic> income = {
        'source': sourceController.text,
        'amount': double.parse(amountController.text),
        'date': DateTime.now().toString(),
      };
      await dbHelper.insertIncome(income);
      sourceController.clear();
      amountController.clear();
      Navigator.pop(context);
    } else {
      // Display an error message if the input fields are empty
      setState(() {
        errorMessage = "Please fill in all fields.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Income"),
        backgroundColor: Colors.green[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add New Income",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green[800]),
            ),
            SizedBox(height: 20),
            TextField(
              controller: sourceController,
              decoration: InputDecoration(
                labelText: 'Income Source',
                prefixIcon: Icon(Icons.source, color: Colors.green),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                prefixIcon: Icon(Icons.attach_money, color: Colors.green),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
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
              onPressed: addIncome,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Updated to use backgroundColor
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                "Save Income",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
