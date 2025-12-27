import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? db;
  static final DatabaseService instance =
      DatabaseService._constructor(); // implements singleton pattern
  DatabaseService._constructor();

  final String userTable = "user";
  final String donationsTable = "donations";
  final String donationHistoryTable = "donation_history";

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
      version: 8,
      onCreate: (db, version) async {
        await createUserTableIfNotExists(db);
        await createDonationsTableIfNotExists(db);
        await createDonationHistoryTableIfNotExists(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await createUserTableIfNotExists(db);
        await createDonationsTableIfNotExists(db);
        await createDonationHistoryTableIfNotExists(db);
        try {
          await db.execute("ALTER TABLE user ADD COLUMN profileImage TEXT;");
        } catch (_) {}
      },
    );
    return database;
  }

  Future createUserTableIfNotExists(Database db) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS ${userTable} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL,
        name TEXT NOT NULL,
        password TEXT NOT NULL,
        profileImage TEXT
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
        image TEXT,
        FOREIGN KEY (userId) REFERENCES user(id)
        )''');
  }

  Future createDonationHistoryTableIfNotExists(Database db) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS ${donationHistoryTable} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        campaignId INTEGER,
        donorId INTEGER,
        amount REAL,
        currency TEXT,
        paymentMethod TEXT,
        isAnonymous INTEGER,
        comment TEXT,
        donatedAt TEXT,
        FOREIGN KEY (campaignId) REFERENCES donations(id),
        FOREIGN KEY (donorId) REFERENCES user(id)
        )''');
  }
}
