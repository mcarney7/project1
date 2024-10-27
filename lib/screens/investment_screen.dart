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
    if (descriptionController.text.isNotEmpty && amountController.text.isNotEmpty) {
      Map<String, dynamic> investment = {
        'description': descriptionController.text,
        'amount': double.parse(amountController.text),
        'date': DateTime.now().toString(),
      };
      await dbHelper.insertInvestment(investment);
      descriptionController.clear();
      amountController.clear();
      Navigator.pop(context);
    } else {
      // Display an error message if input fields are empty
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
        title: Text("Add Investment"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add New Investment",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal[800]),
            ),
            SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Investment Description',
                prefixIcon: Icon(Icons.description, color: Colors.teal),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                prefixIcon: Icon(Icons.attach_money, color: Colors.teal),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
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
              onPressed: addInvestment,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Updated color for consistency
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                "Save Investment",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
