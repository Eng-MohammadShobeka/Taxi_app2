import 'package:get/get.dart';

class CustomerController extends GetxController {
  var username = "مستخدم".obs;

  void updateName(String name) {
    username.value = name;
  }
}
