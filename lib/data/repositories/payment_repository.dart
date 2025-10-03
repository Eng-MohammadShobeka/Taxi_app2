import '../../core/helpers/db_helper.dart';
import '../../data/models/payment.dart';

class PaymentRepository {
  final dbHelper = DBHelper.instance;

  Future<int> insertPayment(Payment payment) async {
    final db = await dbHelper.database;
    return await db.insert('payments', payment.toMap());
  }

  Future<List<Payment>> getPayments() async {
    final db = await dbHelper.database;
    final res = await db.query('payments');
    return res.map((e) => Payment.fromMap(e)).toList();
  }

  Future<Payment?> getPaymentById(int id) async {
    final db = await dbHelper.database;
    final res = await db.query('payments', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Payment.fromMap(res.first) : null;
  }

  Future<int> updatePayment(Payment payment) async {
    final db = await dbHelper.database;
    return await db.update('payments', payment.toMap(), where: 'id = ?', whereArgs: [payment.id]);
  }

  Future<int> deletePayment(int id) async {
    final db = await dbHelper.database;
    return await db.delete('payments', where: 'id = ?', whereArgs: [id]);
  }
}
