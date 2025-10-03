import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final amount = 25.0; // مبلغ افتراضي

    return Scaffold(
      appBar: AppBar(
        title: const Text("الدفع"),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.payment, size: 100, color: Colors.purple),
            const SizedBox(height: 20),
            Text("المبلغ المستحق: $amount \$",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Obx(() => Column(
                  children: [
                    RadioListTile<String>(
                      title: const Text("الدفع نقداً"),
                      value: "Cash",
                      groupValue: controller.selectedMethod.value,
                      onChanged: controller.selectMethod,
                    ),
                    RadioListTile<String>(
                      title: const Text("الدفع عبر البطاقة"),
                      value: "Card",
                      groupValue: controller.selectedMethod.value,
                      onChanged: controller.selectMethod,
                    ),
                    RadioListTile<String>(
                      title: const Text("الدفع عبر PayPal"),
                      value: "PayPal",
                      groupValue: controller.selectedMethod.value,
                      onChanged: controller.selectMethod,
                    ),
                  ],
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.processPayment(amount),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("إتمام الدفع"),
            )
          ],
        ),
      ),
    );
  }
}
