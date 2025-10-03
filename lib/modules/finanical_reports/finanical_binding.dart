import 'package:get/get.dart';
import 'finanical_controller.dart';

class FinancialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FinancialController>(() => FinancialController());
  }
}
