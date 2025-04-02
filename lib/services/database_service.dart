import 'package:habari_pay_cs/models/transaction_response.dart';
import 'package:habari_pay_cs/utils/app_logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService with AppLogger {
  static DatabaseService? _instance;
  static Database? _database;

  static const tableName = 'transactions';

  DatabaseService._();

  static DatabaseService get instance {
    _instance ??= DatabaseService._();
    return _instance!;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize database
  Future<Database> _initDatabase() async {
    try {
      String path = join(await getDatabasesPath(), 'habari_pay.db');
      return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
      );
    } catch (e) {
      log.e('Error initializing database: $e');
      rethrow;
    }
  }

  // Create tables
  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE $tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          transaction_ref TEXT NOT NULL,
          transaction_amount REAL NOT NULL,
          fee REAL NOT NULL,
          merchant_amount REAL NOT NULL,
          email TEXT NOT NULL,
          transaction_status TEXT NOT NULL,
          transaction_currency_id TEXT NOT NULL,
          transaction_type TEXT NOT NULL,
          merchant_name TEXT NOT NULL,
          merchant_business_name TEXT NOT NULL,
          merchant_email TEXT NOT NULL,
          gateway_transaction_ref TEXT NOT NULL,
          created_at TEXT NOT NULL
        )
      ''');

      log.i('Database tables created successfully');
    } catch (e) {
      log.e('Error creating database tables: $e');
      rethrow;
    }
  }

  static Future<bool> addTransaction(TransactionDetail transaction) async {
    final db = await instance.database;
    final result = await db.insert(tableName, transaction.toMap());
    return result > 0;
  }

  static Future<List<TransactionDetail>> fetchTransactions() async {
    final db = await instance.database;
    final results = await db.query(tableName);
    return results.map((item) => TransactionDetail.fromMap(item)).toList();
  }

  // Close database
  Future<void> close() async {
    try {
      final db = await instance.database;
      await db.close();
      _database = null;
      log.i('Database closed successfully');
    } catch (e) {
      log.e('Error closing database: $e');
      rethrow;
    }
  }
}
