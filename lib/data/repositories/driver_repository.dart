import '../../core/helpers/db_helper.dart';
import '../../data/models/driver.dart';

class DriverRepository {
  final dbHelper = DBHelper.instance;

  Future<int> insertDriver(Driver driver) async {
    final db = await dbHelper.database;
    return await db.insert('drivers', driver.toMap());
  }

  Future<List<Driver>> getDrivers() async {
    final db = await dbHelper.database;
    final res = await db.query('drivers');
    return res.map((e) => Driver.fromMap(e)).toList();
  }

  Future<Driver?> getDriverById(int id) async {
    final db = await dbHelper.database;
    final res = await db.query('drivers', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Driver.fromMap(res.first) : null;
  }

  Future<int> updateDriver(Driver driver) async {
    final db = await dbHelper.database;
    return await db.update('drivers', driver.toMap(), where: 'id = ?', whereArgs: [driver.id]);
  }

  Future<int> deleteDriver(int id) async {
    final db = await dbHelper.database;
    return await db.delete('drivers', where: 'id = ?', whereArgs: [id]);
  }
}
