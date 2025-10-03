class AppNotification {
  int? id;
  int userId;
  String title;
  String body;
  String type; // info, ride, payment
  String createdAt;

  AppNotification({
    this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    required this.createdAt,
  });

  factory AppNotification.fromMap(Map<String, dynamic> map) => AppNotification(
        id: map['id'],
        userId: map['userId'],
        title: map['title'],
        body: map['body'],
        type: map['type'],
        createdAt: map['createdAt'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'title': title,
        'body': body,
        'type': type,
        'createdAt': createdAt,
      };
}
