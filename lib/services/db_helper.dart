import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "girl_math_finance.db";
  static final _databaseVersion = 1;

  // Table names
  static final tableExpenses = 'expenses';
  static final tableIncome = 'income';
  static final tableSavings = 'savings';

  // Column names
  static final columnId = 'id';
  static final columnDescription = 'description';
  static final columnAmount = 'amount';
  static final columnDate = 'date';

  // Additional columns for income
  static final columnSource = 'source';

  // Additional columns for savings goals
  static final columnGoalName = 'goalName';
  static final columnGoalAmount = 'goalAmount';
  static final columnCurrentAmount = 'currentAmount';

  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // Create table for expenses
    await db.execute('''
      CREATE TABLE $tableExpenses (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnDescription TEXT NOT NULL,
        $columnAmount REAL NOT NULL,
        $columnDate TEXT NOT NULL
      )
    ''');

    // Create table for income
    await db.execute('''
      CREATE TABLE $tableIncome (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnSource TEXT NOT NULL,
        $columnAmount REAL NOT NULL,
        $columnDate TEXT NOT NULL
      )
    ''');

    // Create table for savings goals
    await db.execute('''
      CREATE TABLE $tableSavings (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnGoalName TEXT NOT NULL,
        $columnGoalAmount REAL NOT NULL,
        $columnCurrentAmount REAL NOT NULL
      )
    ''');
  }

  // INSERT operations

  Future<int> insertExpense(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableExpenses, row);
  }

  Future<int> insertIncome(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableIncome, row);
  }

  Future<int> insertSavingsGoal(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableSavings, row);
  }

  // QUERY operations

  Future<List<Map<String, dynamic>>> queryAllExpenses() async {
    Database db = await instance.database;
    return await db.query(tableExpenses);
  }

  Future<List<Map<String, dynamic>>> queryAllIncome() async {
    Database db = await instance.database;
    return await db.query(tableIncome);
  }

  Future<List<Map<String, dynamic>>> queryAllSavingsGoals() async {
    Database db = await instance.database;
    return await db.query(tableSavings);
  }

  // UPDATE operations

  Future<int> updateSavingsGoal(int id, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update(tableSavings, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateExpense(int id, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update(tableExpenses, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // DELETE operations

  Future<int> deleteExpense(int id) async {
    Database db = await instance.database;
    return await db.delete(tableExpenses, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteIncome(int id) async {
    Database db = await instance.database;
    return await db.delete(tableIncome, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteSavingsGoal(int id) async {
    Database db = await instance.database;
    return await db.delete(tableSavings, where: '$columnId = ?', whereArgs: [id]);
  }
}
