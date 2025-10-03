import 'package:get/get.dart';
import 'package:test_212/modules/complaints/complaints_view.dart';
import 'package:test_212/modules/finanical_reports/finanical_reports_view.dart';
import '../../modules/auth/login_view.dart';
import '../../modules/auth/signup_view.dart';
import '../../modules/customer/customer_home_view.dart';
import '../../modules/driver/driver_home_view.dart';
import '../../modules/admin/admin_dashboard_view.dart';
import '../../modules/ride/ride_details_view.dart';
import '../../modules/ride/ride_tracking_view.dart';
import '../../modules/payment/payment_view.dart';
import '../../modules/notification/notification_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.login, page: () => LoginView()),
    GetPage(name: AppRoutes.signup, page: () => SignupView()),
    GetPage(name: AppRoutes.customerHome, page: () => CustomerHomeView()),
    GetPage(name: AppRoutes.driverHome, page: () => DriverHomeView()),
    GetPage(name: AppRoutes.adminDashboard, page: () => AdminDashboardView()),
    GetPage(name: AppRoutes.rideDetails, page: () => RideDetailsView()),
    GetPage(name: AppRoutes.rideTracking, page: () => RideTrackingView()),
    GetPage(name: AppRoutes.payment, page: () => PaymentView()),
    GetPage(name: AppRoutes.notification, page: () => NotificationView()),
    GetPage(name: AppRoutes.financialReports,page: () => FinancialView()),
     GetPage(name: AppRoutes.complaints, page: () => ComplaintsView()),
  ];
}
