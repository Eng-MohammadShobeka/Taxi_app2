import 'package:get/get.dart';
import '../../modules/auth/auth_controller.dart';
import '../../modules/customer/customer_controller.dart';
import '../../modules/driver/driver_controller.dart';
import '../../modules/admin/admin_controller.dart';
import '../../modules/ride/ride_controller.dart';
import '../../modules/payment/payment_controller.dart';
import '../../core/helpers/db_helper.dart';
import '../../services/location_service.dart';
import '../../services/payment_service.dart';


class InitialBinding extends Bindings {
Future<void> dependencies() async {
// initialize DB
await DBHelper.initDB();


// services
Get.put(LocationService());
Get.put(PaymentService());


// controllers
Get.put(AuthController());
Get.put(CustomerController());
Get.put(DriverController());
Get.put(AdminController());
Get.put(RideController());
Get.put(PaymentController());
}
}