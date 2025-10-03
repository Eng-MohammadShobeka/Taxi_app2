import 'package:get/get.dart';

class PaymentController extends GetxController {
  var selectedMethod = "Cash".obs;

  void selectMethod(String? value) {
  if (value != null) {
    selectedMethod.value = value;
  }
}


  void processPayment(double amount) {
    // هنا من الممكن ربط الدفع مع Stripe أو PayPal
    Get.snackbar("نجاح الدفع", "تم الدفع $amount \$ عن طريق ${selectedMethod.value}");
  }
}
