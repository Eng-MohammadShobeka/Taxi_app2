import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'customer_controller.dart';

class CustomerHomeView extends GetView<CustomerController> {
  CustomerHomeView({super.key});
   final CustomerController controller = Get.put(CustomerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text("مرحباً ${controller.username.value}")),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Get.offAllNamed('/login'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.map, size: 120, color: Colors.amber),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Get.toNamed('/ride-tracking'),
              icon: const Icon(Icons.local_taxi),
              label: const Text("طلب رحلة"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                minimumSize: const Size(200, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
