import 'package:fund_bridge/services/database.dart';

class UserService {
  final DatabaseService databaseService = DatabaseService.instance;

  Future<int> createUser(
    String name,
    String emailAddress,
    String password,
  ) async {
    final db = await databaseService.database;
    return await db.insert(databaseService.userTable, {
      "email": emailAddress,
      "name": name,
      "password": password,
    });
  }

  Future<int?> getUserByEmail(String email) async {
    final db = await databaseService.database;
    final result = await db.query(
      databaseService.userTable,
      where: "email = ?",
      whereArgs: [email],
    );
    return result.isNotEmpty ? result.first['id'] : null;
  }

  Future<Map<String, dynamic>?> getUserById(int id) async {
    final db = await databaseService.database;
    final result = await db.query(
      databaseService.userTable,
      where: "id = ?",
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Map<String, dynamic>.from(result.first);
    }
    return null;
  }

  Future<int?> userLogin(String email, String password) async {
    final db = await databaseService.database;
    final result = await db.query(
      databaseService.userTable,
      where: "email = ? AND password = ?",
      whereArgs: [email, password],
    );
    return result.isNotEmpty ? result.first['id'] : null;
  }

  Future getAllUsers() async {
    final db = await databaseService.database;
    final result = await db.query(databaseService.userTable);
    return result;
  }

  Future deleteUser(String email) async {
    final db = await databaseService.database;
    return await db.delete(
      databaseService.userTable,
      where: "email = ?",
      whereArgs: [email],
    );
  }
}
