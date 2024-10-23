import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeScreen extends StatefulWidget {
  @override
  _IncomeScreenState createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  final TextEditingController amountController = TextEditingController();
  String category = 'Salary';

  Future<void> addIncome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double income = prefs.getDouble('income') ?? 0;
    prefs.setDouble('income', income + double.parse(amountController.text));
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
            TextField(controller: amountController, decoration: InputDecoration(labelText: 'Amount')),
            DropdownButton<String>(
              value: category,
              onChanged: (String newValue) {
                setState(() {
                  category = newValue;
                });
              },
              items: <String>['Salary', 'Freelance', 'Other'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
            ),
            ElevatedButton(onPressed: addIncome, child: Text("Save Income")),
          ],
        ),
      ),
    );
  }
}
