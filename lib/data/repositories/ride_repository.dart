import '../../core/helpers/db_helper.dart';
import '../../data/models/ride.dart';

class RideRepository {
  final dbHelper = DBHelper.instance;

  Future<int> insertRide(Ride ride) async {
    final db = await dbHelper.database;
    return await db.insert('rides', ride.toMap());
  }

  Future<List<Ride>> getRides() async {
    final db = await dbHelper.database;
    final res = await db.query('rides');
    return res.map((e) => Ride.fromMap(e)).toList();
  }

  Future<Ride?> getRideById(int id) async {
    final db = await dbHelper.database;
    final res = await db.query('rides', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Ride.fromMap(res.first) : null;
  }

  Future<int> updateRide(Ride ride) async {
    final db = await dbHelper.database;
    return await db.update('rides', ride.toMap(), where: 'id = ?', whereArgs: [ride.id]);
  }

  Future<int> deleteRide(int id) async {
    final db = await dbHelper.database;
    return await db.delete('rides', where: 'id = ?', whereArgs: [id]);
  }
}
