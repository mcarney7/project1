import 'package:flutter/material.dart';
import 'package:project1/services/db_helper.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  double totalIncome = 0;
  double totalExpenses = 0;
  List<Map<String, dynamic>> expensesList = [];
  List<Map<String, dynamic>> incomeList = [];

  @override
  void initState() {
    super.initState();
    loadReportData();
  }

  Future<void> loadReportData() async {
    // Load all income and expenses from SQLite database
    List<Map<String, dynamic>> allExpenses = await dbHelper.queryAllExpenses();
    List<Map<String, dynamic>> allIncome = await dbHelper.queryAllIncome();

    double totalIncomeAmount = 0;
    double totalExpenseAmount = 0;

    // Sum up all income
    allIncome.forEach((income) {
      totalIncomeAmount += income['amount'];
    });

    // Sum up all expenses
    allExpenses.forEach((expense) {
      totalExpenseAmount += expense['amount'];
    });

    setState(() {
      totalIncome = totalIncomeAmount;
      totalExpenses = totalExpenseAmount;
      expensesList = allExpenses;
      incomeList = allIncome;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Financial Report")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Total Income: \$${totalIncome.toStringAsFixed(2)}", style: TextStyle(fontSize: 18)),
            Text("Total Expenses: \$${totalExpenses.toStringAsFixed(2)}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: expensesList.length,
                itemBuilder: (context, index) {
                  final expense = expensesList[index];
                  return ListTile(
                    title: Text(expense['description']),
                    subtitle: Text("Amount: \$${expense['amount'].toStringAsFixed(2)}"),
                    trailing: Text("Date: ${expense['date']}"),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: incomeList.length,
                itemBuilder: (context, index) {
                  final income = incomeList[index];
                  return ListTile(
                    title: Text(income['source']),
                    subtitle: Text("Amount: \$${income['amount'].toStringAsFixed(2)}"),
                    trailing: Text("Date: ${income['date']}"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
