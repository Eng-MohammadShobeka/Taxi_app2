import 'package:get/get.dart';
import '../../data/models/vehicle.dart';


class DriverController extends GetxController {
  var driverName = "أحمد علي".obs;
  var phoneNumber = "09958849265".obs;
  var email = "ahmed.driver@gmail.com".obs;
  var licenseNumber = "DL-123456".obs;
  var isOnline = false.obs;

  // ✅ تفاصيل السيارة
  var vehicle = Vehicle(
    id: 1,
    driverId: "DR123",
    model: "Toyota Camry 2020",
    plateNumber: "XYZ-4567",
    color: "أبيض",
  ).obs;

  get todayRides => null;

  get earnings => null;

  get rating => null;

  void toggleOnlineStatus() {
    isOnline.value = !isOnline.value;
  }
}
