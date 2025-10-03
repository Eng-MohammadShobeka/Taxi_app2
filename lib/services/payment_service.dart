import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';

class PaymentService {
  static Future<void> init() async {
    Stripe.publishableKey = "YOUR_STRIPE_PUBLISHABLE_KEY";
    await Stripe.instance.applySettings();
  }

  static Future<void> makePayment(int amount, String currency) async {
    try {
      // في العادة ستقوم باستدعاء API من السيرفر لجلب PaymentIntent
      // هنا فقط مثال توضيحي
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      debugPrint("خطأ في عملية الدفع: $e");
      rethrow;
    }
  }
}
