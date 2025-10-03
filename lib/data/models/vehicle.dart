class Vehicle {
  int? id;
  String driverId;
  String model;
  String plateNumber;
  String color;

  Vehicle({
    this.id,
    required this.driverId,
    required this.model,
    required this.plateNumber,
    required this.color,
  });

  factory Vehicle.fromMap(Map<String, dynamic> map) => Vehicle(
    id: map['id'],
    driverId: map['driverId'],
    model: map['model'],
    plateNumber: map['plateNumber'],
    color: map['color'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'driverId': driverId,
    'model': model,
    'plateNumber': plateNumber,
    'color': color,
  };
}
