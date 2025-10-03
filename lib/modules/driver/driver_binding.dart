import 'package:get/get.dart';
import 'driver_controller.dart';

class DriverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverController>(() => DriverController());
  }
}
