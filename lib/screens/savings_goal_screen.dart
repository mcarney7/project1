import 'package:flutter/material.dart';
import 'package:project1/services/db_helper.dart';

class SavingsGoalScreen extends StatefulWidget {
  @override
  _SavingsGoalScreenState createState() => _SavingsGoalScreenState();
}

class _SavingsGoalScreenState extends State<SavingsGoalScreen> {
  final TextEditingController goalNameController = TextEditingController();
  final TextEditingController goalAmountController = TextEditingController();
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> savingsGoals = [];

  @override
  void initState() {
    super.initState();
    loadSavingsGoals();
  }

  Future<void> loadSavingsGoals() async {
    List<Map<String, dynamic>> goals = await dbHelper.queryAllSavingsGoals();
    setState(() {
      savingsGoals = goals;
    });
  }

  Future<void> addSavingsGoal() async {
    if (goalNameController.text.isNotEmpty && goalAmountController.text.isNotEmpty) {
      Map<String, dynamic> savingsGoal = {
        'goalName': goalNameController.text,
        'goalAmount': double.parse(goalAmountController.text),
        'currentAmount': 0.0
      };
      await dbHelper.insertSavingsGoal(savingsGoal);
      goalNameController.clear();
      goalAmountController.clear();
      loadSavingsGoals();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Savings Goals"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add New Savings Goal",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[900]),
            ),
            SizedBox(height: 20),
            TextField(
              controller: goalNameController,
              decoration: InputDecoration(
                labelText: 'Goal Name',
                prefixIcon: Icon(Icons.flag, color: Colors.blue),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: goalAmountController,
              decoration: InputDecoration(
                labelText: 'Goal Amount',
                prefixIcon: Icon(Icons.attach_money, color: Colors.blue),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addSavingsGoal,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Updated to use backgroundColor
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                "Add Goal",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: savingsGoals.length,
                itemBuilder: (context, index) {
                  final goal = savingsGoals[index];
                  double progress = (goal['currentAmount'] / goal['goalAmount']).clamp(0.0, 1.0);
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            goal['goalName'],
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey[300],
                            color: Colors.blue,
                          ),
                          SizedBox(height: 5),
                          Text(
                            "\$${goal['currentAmount'].toStringAsFixed(2)} / \$${goal['goalAmount'].toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "${(progress * 100).toStringAsFixed(1)}% completed",
                            style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
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
