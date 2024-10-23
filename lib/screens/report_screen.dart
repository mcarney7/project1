import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportScreen extends StatelessWidget {
  Future<String> generateReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double income = prefs.getDouble('income') ?? 0;
    double expenses = prefs.getDouble('expenses') ?? 0;
    return 'Income: \$${income.toStringAsFixed(2)}, Expenses: \$${expenses.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reports")),
      body: Center(
        child: FutureBuilder<String>(
          future: generateReport(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return Text(snapshot.data);
            }
          },
        ),
      ),
    );
  }
}
