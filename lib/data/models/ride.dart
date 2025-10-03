class Ride {
  int? id;
  int customerId;
  int driverId;
  String start;
  String destination;
  double distance;
  double price;
  String status; 

  Ride({
    this.id,
    required this.customerId,
    required this.driverId,
    required this.start,
    required this.destination,
    required this.distance,
    required this.price,
    required this.status,
  });

  factory Ride.fromMap(Map<String, dynamic> map) => Ride(
        id: map['id'],
        customerId: map['customerId'],
        driverId: map['driverId'],
        start: map['start'],
        destination: map['destination'],
        distance: map['distance'],
        price: map['price'],
        status: map['status'],
      );

  get customerName => null;

  get driverName => null;

  Map<String, dynamic> toMap() => {
        'id': id,
        'customerId': customerId,
        'driverId': driverId,
        'start': start,
        'destination': destination,
        'distance': distance,
        'price': price,
        'status': status,
      };
}
