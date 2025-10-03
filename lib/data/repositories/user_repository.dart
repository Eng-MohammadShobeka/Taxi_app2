import '../../core/helpers/db_helper.dart';
import '../../data/models/user.dart';

class UserRepository {
  final dbHelper = DBHelper.instance;

  Future<int> insertUser(User user) async {
    final db = await dbHelper.database;
    return await db.insert('users', user.toMap());
  }

  Future<List<User>> getUsers() async {
    final db = await dbHelper.database;
    final res = await db.query('users');
    return res.map((e) => User.fromMap(e)).toList();
  }

  Future<User?> getUserById(int id) async {
    final db = await dbHelper.database;
    final res = await db.query('users', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? User.fromMap(res.first) : null;
  }

  Future<int> updateUser(User user) async {
    final db = await dbHelper.database;
    return await db.update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<int> deleteUser(int id) async {
    final db = await dbHelper.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
