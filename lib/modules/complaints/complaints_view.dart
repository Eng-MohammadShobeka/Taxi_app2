import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'complaints_controller.dart';

class ComplaintsView extends GetView<ComplaintsController> {
  ComplaintsView({super.key});
  ComplaintsController controller = Get.put(ComplaintsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إدارة الشكاوى")),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.complaints.length,
          itemBuilder: (context, i) {
            final c = controller.complaints[i];
            return ListTile(
              title: Text(c['user']),
              subtitle: Text(c['message']),
              trailing: c['resolved']
                  ? const Icon(Icons.check, color: Colors.green)
                  : IconButton(
                      icon: const Icon(Icons.done, color: Colors.red),
                      onPressed: () => controller.resolveComplaint(i),
                    ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          controller.addComplaint("User1", "هناك مشكلة في الرحلة");
        },
      ),
    );
  }
}
