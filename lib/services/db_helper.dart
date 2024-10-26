import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "girl_math_finance.db";
  static final _databaseVersion = 1;

  // Table names
  static final tableExpenses = 'expenses';
  static final tableIncome = 'income';
  static final tableSavings = 'savings';
  static final tableInvestments = 'investments'; // New table for investments

  // Common column names
  static final columnId = 'id';
  static final columnAmount = 'amount';
  static final columnDate = 'date';

  // Additional columns for expenses
  static final columnDescription = 'description';

  // Additional columns for income
  static final columnSource = 'source';

  // Additional columns for savings goals
  static final columnGoalName = 'goalName';
  static final columnGoalAmount = 'goalAmount';
  static final columnCurrentAmount = 'currentAmount';

  // Additional columns for investments
  static final columnInvestmentName = 'name'; // New column for investment name

  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._init();

  // Make _database nullable to handle initialization properly
  static Database? _database;

  DatabaseHelper._init();

  // Getter for the database
  Future<Database> get database async {
    // Use ??= to initialize the database if it's null
    _database ??= await _initDB();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // Create tables
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

    // Create table for investments
    await db.execute('''
      CREATE TABLE $tableInvestments (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnInvestmentName TEXT NOT NULL,
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

  // Insert new expense
  Future<int> insertExpense(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableExpenses, row);
  }

  // Insert new income
  Future<int> insertIncome(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableIncome, row);
  }

  // Insert new savings goal
  Future<int> insertSavingsGoal(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableSavings, row);
  }

  // Insert new investment
  Future<int> insertInvestment(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableInvestments, row);
  }

  // QUERY operations

  // Query all expenses
  Future<List<Map<String, dynamic>>> queryAllExpenses() async {
    Database db = await instance.database;
    return await db.query(tableExpenses);
  }

  // Query all income
  Future<List<Map<String, dynamic>>> queryAllIncome() async {
    Database db = await instance.database;
    return await db.query(tableIncome);
  }

  // Query all savings goals
  Future<List<Map<String, dynamic>>> queryAllSavingsGoals() async {
    Database db = await instance.database;
    return await db.query(tableSavings);
  }

  // Query all investments
  Future<List<Map<String, dynamic>>> queryAllInvestments() async {
    Database db = await instance.database;
    return await db.query(tableInvestments);
  }

  // UPDATE operations

  // Update savings goal
  Future<int> updateSavingsGoal(int id, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update(
      tableSavings,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Update expense
  Future<int> updateExpense(int id, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update(
      tableExpenses,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Update income
  Future<int> updateIncome(int id, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update(
      tableIncome,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Update investment
  Future<int> updateInvestment(int id, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update(
      tableInvestments,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // DELETE operations

  // Delete expense
  Future<int> deleteExpense(int id) async {
    Database db = await instance.database;
    return await db.delete(
      tableExpenses,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Delete income
  Future<int> deleteIncome(int id) async {
    Database db = await instance.database;
    return await db.delete(
      tableIncome,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Delete savings goal
  Future<int> deleteSavingsGoal(int id) async {
    Database db = await instance.database;
    return await db.delete(
      tableSavings,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Delete investment
  Future<int> deleteInvestment(int id) async {
    Database db = await instance.database;
    return await db.delete(
      tableInvestments,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
