import 'package:flutter/material.dart';

class GirlMathCalculatorScreen extends StatefulWidget {
  @override
  _GirlMathCalculatorScreenState createState() => _GirlMathCalculatorScreenState();
}

class _GirlMathCalculatorScreenState extends State<GirlMathCalculatorScreen> {
  final TextEditingController _expenseTitleController = TextEditingController();
  final TextEditingController _expenseController = TextEditingController();
  String result = "";

  // This function will simulate "girl math" calculations.
  void calculateGirlMath() {
    if (_expenseController.text.isNotEmpty && _expenseTitleController.text.isNotEmpty) {
      double expense = double.parse(_expenseController.text);
      setState(() {
        // Breakdown of the expense by day, month, and year
        double dailyCost = expense / 365;
        double monthlyCost = expense / 12;
        result = "Expense Breakdown for '${_expenseTitleController.text}':\n" +
                 "- Total: \$${expense.toStringAsFixed(2)}\n" +
                 "- Daily: \$${dailyCost.toStringAsFixed(2)}\n" +
                 "- Monthly: \$${monthlyCost.toStringAsFixed(2)}\n" +
                 "- Yearly: \$${expense.toStringAsFixed(2)}\n\n" +
                 "Totally worth it!";
      });
    } else {
      setState(() {
        result = "Please enter both the title and amount of the expense to calculate.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Girl Math Calculator"),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Calculate Your Girl Math",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.purple[800]),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _expenseTitleController,
              decoration: InputDecoration(
                labelText: 'Expense Title',
                prefixIcon: Icon(Icons.title, color: Colors.purple),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _expenseController,
              decoration: InputDecoration(
                labelText: 'Expense Amount',
                prefixIcon: Icon(Icons.attach_money, color: Colors.purple),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateGirlMath,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple, // Button color
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                "Calculate",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            if (result.isNotEmpty)
              Text(
                result,
                style: TextStyle(fontSize: 18, color: Colors.purple[700]),
              ),
          ],
        ),
      ),
    );
  }
}
