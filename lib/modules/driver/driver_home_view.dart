import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'driver_controller.dart';

class DriverHomeView extends GetView<DriverController> {
  DriverHomeView({super.key});
  final DriverController controller = Get.put(DriverController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text("مرحباً ${controller.driverName.value}")),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Get.snackbar("الإشعارات", "لا توجد إشعارات حالياً");
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Get.offAllNamed('/login'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ حالة الاتصال
            Obx(() => SwitchListTile(
                  title: Text(
                    controller.isOnline.value ? "متصل الآن 🚖" : "غير متصل ❌",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  value: controller.isOnline.value,
                  onChanged: (value) => controller.toggleOnlineStatus(),
                  activeColor: Colors.green,
                )),
            const SizedBox(height: 20),

            // ✅ تفاصيل السائق (الجديد)
            const Text(
              "تفاصيل السائق",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Obx(() => Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("الاسم: ${controller.driverName.value}",
                            style: const TextStyle(fontSize: 16)),
                        Text("رقم الهاتف: ${controller.phoneNumber.value}",
                            style: const TextStyle(fontSize: 16)),
                        Text("البريد الإلكتروني: ${controller.email.value}",
                            style: const TextStyle(fontSize: 16)),
                        Text("رقم الرخصة: ${controller.licenseNumber.value}",
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                )),
            const SizedBox(height: 20),

            // ✅ تفاصيل السيارة
            const Text(
              "تفاصيل السيارة",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Obx(() {
              final car = controller.vehicle.value;
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("الموديل: ${car.model}",
                          style: const TextStyle(fontSize: 16)),
                      Text("رقم اللوحة: ${car.plateNumber}",
                          style: const TextStyle(fontSize: 16)),
                      Text("اللون: ${car.color}",
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),

            // ✅ الشبكة (البطاقات)
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
              children: [
                _buildCard("رحلات اليوم", "6", Icons.local_taxi, Colors.orange,
                    () => Get.toNamed('/ride-details')),
                _buildCard("الأرباح", "\$125", Icons.attach_money, Colors.green,
                    () => Get.toNamed('/finance')),
                _buildCard("التقييم", "⭐ 4.7", Icons.star, Colors.amber, () {
                  Get.snackbar("التقييمات", "متوسط تقييمك 4.7 من 5");
                }),
                Obx(() => controller.isOnline.value
                    ? _buildCard("الخريطة", "الموقع الحالي", Icons.map,
                        Colors.blue, () => Get.toNamed('/ride-tracking'))
                    : const SizedBox()), // يظهر فقط عند الاتصال
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String value, IconData icon, Color color,
      VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        color: color.withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 10),
              Text(value,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 6),
              Text(title,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
