import 'package:flutter/material.dart';
import 'package:project1/services/db_helper.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  double totalIncome = 0.0;
  double totalExpenses = 0.0;

  @override
  void initState() {
    super.initState();
    loadReportData();
  }

  Future<void> loadReportData() async {
    List<Map<String, dynamic>> allIncome = await dbHelper.queryAllIncome();
    List<Map<String, dynamic>> allExpenses = await dbHelper.queryAllExpenses();

    double totalIncomeAmount = 0.0;
    double totalExpenseAmount = 0.0;

    allIncome.forEach((income) => totalIncomeAmount += income['amount']);
    allExpenses.forEach((expense) => totalExpenseAmount += expense['amount']);

    setState(() {
      totalIncome = totalIncomeAmount;
      totalExpenses = totalExpenseAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Financial Report"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Financial Summary",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildReportCard(
              title: "Total Income",
              value: totalIncome,
              color: Colors.green[300]!,
            ),
            SizedBox(height: 10),
            _buildReportCard(
              title: "Total Expenses",
              value: totalExpenses,
              color: Colors.red[300]!,
            ),
            SizedBox(height: 20),
            _buildBalanceSummary(),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard({required String title, required double value, required Color color}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              "\$${value.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceSummary() {
    double netBalance = totalIncome - totalExpenses;
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: netBalance >= 0 ? Colors.blueAccent : Colors.redAccent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Net Balance",
              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              "\$${netBalance.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
