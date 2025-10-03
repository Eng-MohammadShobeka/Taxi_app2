import '../../core/helpers/db_helper.dart';
import '../../data/models/vehicle.dart';

class VehicleRepository {
  final dbHelper = DBHelper.instance;

  Future<int> insertVehicle(Vehicle vehicle) async {
    final db = await dbHelper.database;
    return await db.insert('vehicles', vehicle.toMap());
  }

  Future<List<Vehicle>> getVehicles() async {
    final db = await dbHelper.database;
    final res = await db.query('vehicles');
    return res.map((e) => Vehicle.fromMap(e)).toList();
  }

  Future<Vehicle?> getVehicleById(int id) async {
    final db = await dbHelper.database;
    final res = await db.query('vehicles', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Vehicle.fromMap(res.first) : null;
  }

  Future<int> updateVehicle(Vehicle vehicle) async {
    final db = await dbHelper.database;
    return await db.update('vehicles', vehicle.toMap(), where: 'id = ?', whereArgs: [vehicle.id]);
  }

  Future<int> deleteVehicle(int id) async {
    final db = await dbHelper.database;
    return await db.delete('vehicles', where: 'id = ?', whereArgs: [id]);
  }
}
