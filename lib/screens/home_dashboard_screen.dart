import 'package:flutter/material.dart';

class HomeDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Total Balance: \$5000"),
            Text("Savings Goal: 60%"),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/income');
              },
              child: Text("Add Income"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/expenses');
              },
              child: Text("Add Expenses"),
            ),
          ],
        ),
      ),
    );
  }
}
