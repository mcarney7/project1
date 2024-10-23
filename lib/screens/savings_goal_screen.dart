import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavingsGoalScreen extends StatefulWidget {
  @override
  _SavingsGoalScreenState createState() => _SavingsGoalScreenState();
}

class _SavingsGoalScreenState extends State<SavingsGoalScreen> {
  final TextEditingController goalController = TextEditingController();
  final TextEditingController contributionController = TextEditingController();

  Future<void> setGoal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('savings_goal', double.parse(goalController.text));
    prefs.setDouble('contribution', double.parse(contributionController.text));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Set Savings Goal")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: goalController, decoration: InputDecoration(labelText: 'Goal Amount')),
            TextField(controller: contributionController, decoration: InputDecoration(labelText: 'Monthly Contribution')),
            ElevatedButton(onPressed: setGoal, child: Text("Save Goal")),
          ],
        ),
      ),
    );
  }
}
