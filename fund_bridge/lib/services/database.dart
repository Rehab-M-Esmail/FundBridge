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

  Future<Database> get database async {
    if (db != null) {
      return db!;
    }
    db = await getDatabase();
    return db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "fundBridge.db");
    final database = await openDatabase(
      databasePath,
      version: 11, // Bumped to 11 to force upgrade logic
      onCreate: (db, version) async {
        await createUserTableIfNotExists(db);
        await createDonationsTableIfNotExists(db);
        await createDonationHistoryTableIfNotExists(db);
        
        // Prime the ID counter to 21
        await _primeDonationsId(db);
      },

      onUpgrade: (db, oldVersion, newVersion) async {
        await createUserTableIfNotExists(db);
        await createDonationsTableIfNotExists(db);
        await createDonationHistoryTableIfNotExists(db);
        
        if (oldVersion < 11) {
           await _primeDonationsId(db);
        }

        try {
          await db.execute("ALTER TABLE user ADD COLUMN profileImage TEXT;");
        } catch (_) {}
      },
    );
    return database;
  }

  Future<void> _primeDonationsId(Database db) async {
    // Check if table is empty or has IDs less than 20
    final result = await db.rawQuery("SELECT MAX(id) as max_id FROM $donationsTable");
    int maxId = (result.first['max_id'] as int?) ?? 0;
    
    if (maxId < 20) {
      // Manually insert a record with ID 20 and then delete it
      // This forces the internal SQLite counter to 20
      await db.execute("INSERT INTO $donationsTable (id, title) VALUES (20, 'System Init')");
      await db.execute("DELETE FROM $donationsTable WHERE id = 20");
      
      // Also update the sequence table as a backup
      await db.execute("INSERT OR REPLACE INTO sqlite_sequence (name, seq) VALUES ('$donationsTable', 20)");
    }
  }

  Future createUserTableIfNotExists(Database db) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS $userTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL,
        name TEXT NOT NULL,
        password TEXT NOT NULL,
        profileImage TEXT
        )''');
  }

  Future createDonationsTableIfNotExists(Database db) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS $donationsTable (
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
    await db.execute('''CREATE TABLE IF NOT EXISTS $donationHistoryTable (
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
