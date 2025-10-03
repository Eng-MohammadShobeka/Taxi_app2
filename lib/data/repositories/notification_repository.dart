import '../../core/helpers/db_helper.dart';
import '../../data/models/notification.dart';

class NotificationRepository {
  final dbHelper = DBHelper.instance;

  Future<int> insertNotification(AppNotification notification) async {
    final db = await dbHelper.database;
    return await db.insert('notifications', notification.toMap());
  }

  Future<List<AppNotification>> getNotifications() async {
    final db = await dbHelper.database;
    final res = await db.query('notifications');
    return res.map((e) => AppNotification.fromMap(e)).toList();
  }

  Future<AppNotification?> getNotificationById(int id) async {
    final db = await dbHelper.database;
    final res = await db.query('notifications', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? AppNotification.fromMap(res.first) : null;
  }

  Future<int> updateNotification(AppNotification notification) async {
    final db = await dbHelper.database;
    return await db.update('notifications', notification.toMap(), where: 'id = ?', whereArgs: [notification.id]);
  }

  Future<int> deleteNotification(int id) async {
    final db = await dbHelper.database;
    return await db.delete('notifications', where: 'id = ?', whereArgs: [id]);
  }
}
