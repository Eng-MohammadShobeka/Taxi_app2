class Driver {
  int? id;
  String name;
  String licenseNumber;
  String phone;
  String vehicleId;

  Driver({
    this.id,
    required this.name,
    required this.licenseNumber,
    required this.phone,
    required this.vehicleId,
  });

  factory Driver.fromMap(Map<String, dynamic> map) => Driver(
        id: map['id'],
        name: map['name'],
        licenseNumber: map['licenseNumber'],
        phone: map['phone'],
        vehicleId: map['vehicleId'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'licenseNumber': licenseNumber,
        'phone': phone,
        'vehicleId': vehicleId,
      };
}
