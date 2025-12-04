import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? db;
  static final DatabaseService instance =
      DatabaseService._constructor(); // implements singleton pattern
  DatabaseService._constructor();

  final String userTable = "user";
  final String donationsTable = "donations";

  Future get database async {
    if (db != null) {
      return db;
    }
    db = await getDatabase();
    return db;
  }

  Future getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "fundBridge.db");
    final database = await openDatabase(
      databasePath,
      version: 6,
      onCreate: (db, version) async {
        await createUserTableIfNotExists(db);
        await createDonationsTableIfNotExists(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute("DROP TABLE IF EXISTS user;");
        await db.execute("DROP TABLE IF EXISTS donations;");
        await createUserTableIfNotExists(db);
        await createDonationsTableIfNotExists(db);
      },
    );
    return database;
  }

  Future createUserTableIfNotExists(Database db) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS ${userTable} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL,
        name TEXT NOT NULL,
        password TEXT NOT NULL    
        )''');
  }

  Future createDonationsTableIfNotExists(Database db) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS ${donationsTable} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        donationTarget TEXT,
        donationGoal INTEGER,
        title TEXT,
        description TEXT,
        image BLOB,
        FOREIGN KEY (userId) REFERENCES user(id)
        )''');
  }
}
