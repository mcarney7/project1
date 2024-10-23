import 'package:flutter/material.dart';
import 'package:project1/services/db_helper.dart';

class SavingsGoalScreen extends StatefulWidget {
  @override
  _SavingsGoalScreenState createState() => _SavingsGoalScreenState();
}

class _SavingsGoalScreenState extends State<SavingsGoalScreen> {
  final TextEditingController goalNameController = TextEditingController();
  final TextEditingController goalAmountController = TextEditingController();
  final TextEditingController contributionController = TextEditingController();
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  List<Map<String, dynamic>> savingsGoals = [];

  @override
  void initState() {
    super.initState();
    loadSavingsGoals();
  }

  // Load all savings goals from the database
  Future<void> loadSavingsGoals() async {
    List<Map<String, dynamic>> goals = await dbHelper.queryAllSavingsGoals();
    setState(() {
      savingsGoals = goals;
    });
  }

  // Add a new savings goal to the database
  Future<void> addSavingsGoal() async {
    Map<String, dynamic> savingsGoal = {
      'goalName': goalNameController.text,
      'goalAmount': double.parse(goalAmountController.text),
      'currentAmount': 0.0
    };
    await dbHelper.insertSavingsGoal(savingsGoal);
    goalNameController.clear();
    goalAmountController.clear();
    contributionController.clear();
    loadSavingsGoals(); // Reload goals after adding
  }

  // Update progress on the savings goal
  Future<void> contributeToGoal(int id, double currentAmount) async {
    double contribution = double.parse(contributionController.text);
    Map<String, dynamic> updatedGoal = {
      'currentAmount': currentAmount + contribution,
    };
    await dbHelper.updateSavingsGoal(id, updatedGoal);
    contributionController.clear();
    loadSavingsGoals(); // Reload goals after updating
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Savings Goals")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input for a new savings goal
            TextField(controller: goalNameController, decoration: InputDecoration(labelText: 'Goal Name')),
            TextField(controller: goalAmountController, decoration: InputDecoration(labelText: 'Goal Amount')),
            ElevatedButton(onPressed: addSavingsGoal, child: Text("Add Savings Goal")),
            SizedBox(height: 20),
            // Display all savings goals
            Expanded(
              child: ListView.builder(
                itemCount: savingsGoals.length,
                itemBuilder: (context, index) {
                  final goal = savingsGoals[index];
                  double progress = (goal['currentAmount'] / goal['goalAmount']) * 100;
                  return ListTile(
                    title: Text(goal['goalName']),
                    subtitle: Text(
                      "Goal: \$${goal['goalAmount'].toStringAsFixed(2)}, "
                      "Current: \$${goal['currentAmount'].toStringAsFixed(2)}, "
                      "Progress: ${progress.toStringAsFixed(1)}%",
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        // Contribution dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Contribute to ${goal['goalName']}"),
                              content: TextField(
                                controller: contributionController,
                                decoration: InputDecoration(labelText: "Contribution Amount"),
                                keyboardType: TextInputType.number,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text("Contribute"),
                                  onPressed: () {
                                    contributeToGoal(goal['id'], goal['currentAmount']);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
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
