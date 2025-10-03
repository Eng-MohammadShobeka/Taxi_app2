import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الإشعارات"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            controller.showNotification(
              "رحلة جديدة 🚖",
              "تم تأكيد رحلتك والسائق في الطريق إليك.",
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          icon: const Icon(Icons.notifications_active, size: 28),
          label: const Text(
            "إرسال إشعار تجريبي",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
