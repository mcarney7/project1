class Expense {
  int id;
  String description;
  double amount;
  String date;

  Expense({this.id, this.description, this.amount, this.date});

  // Convert an Expense into a Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'date': date,
    };
  }

  // Create an Expense object from a Map
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      description: map['description'],
      amount: map['amount'],
      date: map['date'],
    );
  }
}
