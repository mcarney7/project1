class Income {
  int id;
  String source;
  double amount;
  String date;

  Income({this.id, this.source, this.amount, this.date});

  // Convert an Income into a Map. Useful for inserting data into SQLite.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'source': source,
      'amount': amount,
      'date': date,
    };
  }

  // Extract an Income object from a Map. Useful for retrieving data from SQLite.
  factory Income.fromMap(Map<String, dynamic> map) {
    return Income(
      id: map['id'],
      source: map['source'],
      amount: map['amount'],
      date: map['date'],
    );
  }
}
