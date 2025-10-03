import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxString role = 'مستخدم'.obs; // قيمة افتراضية
  RxBool isLoading = false.obs;

  void login() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      Get.snackbar('خطأ', 'الرجاء ملء جميع الحقول',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));

    // التوجيه حسب الدور
    switch (role.value) {
      case 'مستخدم':
        Get.offAllNamed('/customerHome',
            arguments: {"email": emailController.text});
        break;
      case 'سائق':
        Get.offAllNamed('/driverHome',
            arguments: {"email": emailController.text});
        break;
      case 'أدمن':
        Get.offAllNamed('/adminDashboard',
            arguments: {"email": emailController.text});
        break;
    }

    isLoading.value = false;
  }

  void signup() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      Get.snackbar('خطأ', 'الرجاء ملء جميع الحقول',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));

    Get.snackbar('نجاح', 'تم إنشاء الحساب بنجاح\nالدور: ${role.value}',
        snackPosition: SnackPosition.BOTTOM);

    isLoading.value = false;
  }

  void clearAll() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    role.value = 'مستخدم';
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
