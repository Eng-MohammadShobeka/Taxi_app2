class Payment {
  int? id;
  int rideId;
  double amount;
  String method; // cash, stripe, paypal
  String status; // pending, success, failed

  Payment({
    this.id,
    required this.rideId,
    required this.amount,
    required this.method,
    required this.status,
  });

  factory Payment.fromMap(Map<String, dynamic> map) => Payment(
        id: map['id'],
        rideId: map['rideId'],
        amount: map['amount'],
        method: map['method'],
        status: map['status'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'rideId': rideId,
        'amount': amount,
        'method': method,
        'status': status,
      };
}
