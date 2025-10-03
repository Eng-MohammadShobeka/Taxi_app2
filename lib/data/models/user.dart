class User {
  int? id;
  String name;
  String email;
  String password;
  String role; // customer, driver, admin

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  factory User.fromMap(Map<String, dynamic> map) => User(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        password: map['password'],
        role: map['role'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'role': role,
      };
}
