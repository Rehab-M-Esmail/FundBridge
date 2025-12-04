import 'dart:io';
import 'package:fund_bridge/services/database.dart';

class DonationsService {
  final DatabaseService databaseService = DatabaseService.instance;

  Future createDonation(
    int userId,
    String title,
    int goal,
    String description,
    String target,
    File image,
  ) async {
    final db = await databaseService.database;
    return await db.insert(databaseService.donationsTable, {
      'userId': userId,
      'donationTarget': target,
      'donationGoal': goal,
      'title': title,
      'description': description,
      'image': image,
    });
  }

  Future getAllDonations() async {
    final db = await databaseService.database;
    final result = await db.query(databaseService.donationsTable);
    return result;
  }

  Future deleteDonation(String donationId) async {
    final db = await databaseService.database;
    return await db.delete(
      databaseService.donationsTable,
      where: 'id = ?',
      whereArgs: [donationId],
    );
  }
}
