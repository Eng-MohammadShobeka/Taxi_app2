import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Core
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'core/bindings/initial_binding.dart';
import 'core/theme/app_theme.dart';

// Services
import 'services/notification_service.dart';
import 'services/payment_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة الإشعارات
  await NotificationService.init();

  // تهيئة الدفع (Stripe مثلاً)
  // await PaymentService.init();

  runApp(const TaxiApp());
}

class TaxiApp extends StatelessWidget {
  const TaxiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Taxi App",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.login,
      getPages: AppPages.pages,
      initialBinding: InitialBinding(),
    );
  }
}
