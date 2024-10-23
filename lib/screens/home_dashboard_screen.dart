import 'package:flutter/material.dart';
import 'package:project1/services/shared_preferences_helper.dart';

class HomeDashboard extends StatefulWidget {
  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  double balance = 0;

  @override
  void initState() {
    super.initState();
    loadBalance();
  }

  Future<void> loadBalance() async {
    double savedBalance = await SharedPreferencesHelper.getBalance();
    setState(() {
      balance = savedBalance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Total Balance: \$${balance.toStringAsFixed(2)}"),
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
