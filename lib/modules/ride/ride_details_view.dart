import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ride_controller.dart';

class RideDetailsView extends GetView<RideController> {
  RideDetailsView({super.key});
  final RideController controller = Get.put(RideController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تفاصيل الرحلات"),
        backgroundColor: Colors.teal,
      ),
      body: Obx(() {
        if (controller.rides.isEmpty) {
          return const Center(child: Text("لا توجد رحلات حالياً"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: controller.rides.length,
          itemBuilder: (context, index) {
            final ride = controller.rides[index];
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("المسافر: ${ride.customerName}",
                        style: const TextStyle(fontSize: 18)),
                    const Divider(),
                    Text("السائق: ${ride.driverName}",
                        style: const TextStyle(fontSize: 18)),
                    const Divider(),
                    Text("المسافة: ${ride.distance} كم",
                        style: const TextStyle(fontSize: 18)),
                    const Divider(),
                    Text("السعر: ${ride.price} \$",
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => controller.acceptRide(index as Ride),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              minimumSize: const Size(double.infinity, 45),
                            ),
                            child: const Text("قبول"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => controller.rejectRide(index as Ride),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              minimumSize: const Size(double.infinity, 45),
                            ),
                            child: const Text("رفض"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
