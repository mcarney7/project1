class Income {
  int id;
  String source;
  double amount;
  String date;

  Income({this.id, this.source, this.amount, this.date});

  // Convert Income into a Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'source': source,
      'amount': amount,
      'date': date,
    };
  }

  // Create Income object from a Map
  factory Income.fromMap(Map<String, dynamic> map) {
    return Income(
      id: map['id'],
      source: map['source'],
      amount: map['amount'],
      date: map['date'],
    );
  }
}
