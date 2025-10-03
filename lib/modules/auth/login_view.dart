import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';
import '../../core/routes/app_routes.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final AuthController controller = Get.put(AuthController());

  final roles = ['مستخدم', 'سائق', 'أدمن'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orangeAccent, Colors.deepOrangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    const Icon(Icons.login, size: 100, color: Colors.orange),
                    const SizedBox(height: 20),

                    // البريد الإلكتروني
                    TextField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        labelText: "البريد الإلكتروني",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // كلمة المرور
                    TextField(
                      controller: controller.passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "كلمة المرور",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // اختيار الدور
                    Obx(() => DropdownButtonFormField<String>(
                          value: controller.role.value,
                          items: roles
                              .map((r) =>
                                  DropdownMenuItem(value: r, child: Text(r)))
                              .toList(),
                          onChanged: (v) {
                            if (v != null) controller.role.value = v;
                          },
                          decoration: const InputDecoration(
                            labelText: "اختر الدور",
                            prefixIcon: Icon(Icons.supervised_user_circle),
                            border: OutlineInputBorder(),
                          ),
                        )),
                    const SizedBox(height: 20),

                    // زر تسجيل الدخول
                    Obx(() => controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              if (controller.emailController.text.isEmpty ||
                                  controller.passwordController.text.isEmpty) {
                                Get.snackbar(
                                  'خطأ',
                                  'الرجاء ملء جميع الحقول',
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                                return;
                              }

                              controller.isLoading.value = true;
                              Future.delayed(const Duration(seconds: 1), () {
                                controller.isLoading.value = false;

                                // التنقل حسب الدور
                                switch (controller.role.value) {
                                  case 'مستخدم':
                                    Get.offAllNamed(AppRoutes.customerHome);
                                    break;
                                  case 'سائق':
                                    Get.offAllNamed(AppRoutes.driverHome);
                                    break;
                                  case 'أدمن':
                                    Get.offAllNamed(AppRoutes.adminDashboard);
                                    break;
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              "تسجيل الدخول",
                              style: TextStyle(fontSize: 18),
                            ),
                          )),

                    TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.signup),
                      child: const Text("ليس لديك حساب؟ سجل الآن"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
