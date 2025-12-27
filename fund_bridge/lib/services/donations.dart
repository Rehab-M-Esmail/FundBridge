import 'package:fund_bridge/services/database.dart';

class DonationsService {
  final DatabaseService databaseService = DatabaseService.instance;

  Future createDonation(
    int userId,
    String title,
    int goal,
    String description,
    String target,
    String image,
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

  Future deleteDonation(int donationId) async {
    final db = await databaseService.database;
    return await db.delete(
      databaseService.donationsTable,
      where: 'id = ?',
      whereArgs: [donationId],
    );
  }

  Future<Map<String, dynamic>?> getDonationById(int donationId) async {
    final db = await databaseService.database;
    final result = await db.query(
      databaseService.donationsTable,
      where: 'id = ?',
      whereArgs: [donationId],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<int> getTotalRaisedAmount(int donationId) async {
    final db = await databaseService.database;
    final result = await db.rawQuery(
      'SELECT SUM(amount) as total FROM ${databaseService.donationHistoryTable} WHERE campaignId = ?',
      [donationId],
    );
    if (result.isNotEmpty && result.first['total'] != null) {
      return (result.first['total'] as num).toInt();
    }
    return 0;
  }

  Future<int> saveDonation({
    required int campaignId,
    required int donorId,
    required double amount,
    required String currency,
    required String paymentMethod,
    required bool isAnonymous,
    String? comment,
  }) async {
    final db = await databaseService.database;
    return await db.insert(databaseService.donationHistoryTable, {
      'campaignId': campaignId,
      'donorId': donorId,
      'amount': amount,
      'currency': currency,
      'paymentMethod': paymentMethod,
      'isAnonymous': isAnonymous ? 1 : 0,
      'comment': comment ?? '',
      'donatedAt': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getDonationHistory(int campaignId) async {
    final db = await databaseService.database;
    final result = await db.query(
      databaseService.donationHistoryTable,
      where: 'campaignId = ?',
      whereArgs: [campaignId],
      orderBy: 'donatedAt DESC',
    );
    return result;
  }

  Future<List<Map<String, dynamic>>> getDonationsByUserId(int userId) async {
    final db = await databaseService.database;
    final campaigns = await db.query(
      databaseService.donationsTable,
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'id DESC',
    );

    final result = <Map<String, dynamic>>[];
    for (final c in campaigns) {
      final id = c['id'];
      if (id is int) {
        final totalRaised = await getTotalRaisedAmount(id);
        result.add({...c, 'totalRaised': totalRaised});
      } else {
        result.add({...c, 'totalRaised': 0});
      }
    }
    return result;
  }
}
