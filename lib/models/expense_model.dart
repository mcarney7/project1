class Expense {
  int id;
  String description;
  double amount;
  String date;

  Expense({this.id, this.description, this.amount, this.date});

  // Convert an Expense into a Map. Useful for inserting data into SQLite.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'date': date,
    };
  }

  // Extract an Expense object from a Map. Useful for retrieving data from SQLite.
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      description: map['description'],
      amount: map['amount'],
      date: map['date'],
    );
  }
}
