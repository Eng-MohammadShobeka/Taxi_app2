import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'finanical_controller.dart';

class FinancialView extends GetView<FinancialController> {
  FinancialController controller = Get.put((FinancialController()));
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("التقارير المالية")),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.reports.length,
                itemBuilder: (context, i) {
                  final r = controller.reports[i];
                  return ListTile(
                    leading: const Icon(
                      Icons.attach_money,
                      color: Colors.green,
                    ),
                    title: Text(r["title"]),
                    subtitle: Text(
                      "المبلغ: ${r["amount"]} - التاريخ: ${r["date"]}",
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => controller.removeReport(i),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "عنوان التقرير"),
                ),
                TextField(
                  controller: amountController,
                  decoration: const InputDecoration(labelText: "المبلغ"),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  child: const Text("إضافة تقرير"),
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        amountController.text.isNotEmpty) {
                      controller.addFinancialReport(
                        titleController.text,
                        double.tryParse(amountController.text) ?? 0.0,
                      );
                      titleController.clear();
                      amountController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
