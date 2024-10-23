class SavingsGoal {
  int id;
  String goalName;
  double goalAmount;
  double currentAmount;

  SavingsGoal({this.id, this.goalName, this.goalAmount, this.currentAmount});

  // Convert a SavingsGoal into a Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'goalName': goalName,
      'goalAmount': goalAmount,
      'currentAmount': currentAmount,
    };
  }

  // Create SavingsGoal object from a Map
  factory SavingsGoal.fromMap(Map<String, dynamic> map) {
    return SavingsGoal(
      id: map['id'],
      goalName: map['goalName'],
      goalAmount: map['goalAmount'],
      currentAmount: map['currentAmount'],
    );
  }
}
