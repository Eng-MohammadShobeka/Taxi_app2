import 'package:get/get.dart';

// نماذج بيانات
class Driver {
  String name;
  String carType;
  bool isOnline;
  double rating;

  Driver({
    required this.name,
    required this.carType,
    required this.isOnline,
    required this.rating,
  });
}

class User {
  String name;
  String email;

  User({required this.name, required this.email});
}

class Complaint {
  String title;
  String description;

  Complaint({required this.title, required this.description});
}

class FinancialReport {
  String title;
  double amount;

  FinancialReport({required this.title, required this.amount});
}

class AdminController extends GetxController {
  var totalUsers = 0.obs;
  var totalDrivers = 0.obs;
  var totalRides = 0.obs;
  var averageRating = 0.0.obs;
  var totalEarnings = 0.0.obs;

  var drivers = <Driver>[].obs;
  var users = <User>[].obs;
  var complaints = <Complaint>[].obs;
  var financialReports = <FinancialReport>[].obs;

  @override
  void onInit() {
    super.onInit();
    refreshStats(); // ملء البيانات الافتراضية
  }

  void refreshStats() {
    totalUsers.value = 7;
    totalDrivers.value = 7;
    totalRides.value = 14;
    averageRating.value = 4.5;
    totalEarnings.value = 2000.0;

    drivers.assignAll([
      Driver(name: "أحمد", carType: "سيارة صغيرة", isOnline: true, rating: 4.5),
      Driver(name: "محمد", carType: "سيارة كبيرة", isOnline: false, rating: 4.2),
      Driver(name: "سعيد", carType: "سيارة متوسطة", isOnline: true, rating: 4.8),
      Driver(name: "خالد", carType: "سيارة صغيرة", isOnline: true, rating: 4.0),
      Driver(name: "ياسر", carType: "سيارة كبيرة", isOnline: false, rating: 4.3),
      Driver(name: "رامي", carType: "سيارة متوسطة", isOnline: true, rating: 4.7),
      Driver(name: "فهد", carType: "سيارة صغيرة", isOnline: true, rating: 4.6),
    ]);

    users.assignAll([
      User(name: "سارة", email: "sara@example.com"),
      User(name: "ليلى", email: "laila@example.com"),
      User(name: "علي", email: "ali@example.com"),
      User(name: "هند", email: "hend@example.com"),
      User(name: "يوسف", email: "yousef@example.com"),
      User(name: "نور", email: "noor@example.com"),
      User(name: "منى", email: "mona@example.com"),
    ]);

    complaints.assignAll([
      Complaint(title: "تأخير", description: "السائق تأخر 10 دقائق"),
      Complaint(title: "سلوك غير لائق", description: "المستخدم اشتكى من السائق"),
      Complaint(title: "عدم الالتزام بالمسار", description: "الرحلة لم تتبع المسار المحدد"),
      Complaint(title: "سيارة غير نظيفة", description: "السيارة كانت متسخة"),
      Complaint(title: "تأخير الدفع", description: "المستخدم لم يدفع في الوقت المحدد"),
      Complaint(title: "مشكلة GPS", description: "الموقع غير دقيق أثناء الرحلة"),
      Complaint(title: "إلغاء مفاجئ", description: "تم إلغاء الرحلة بدون سبب"),
    ]);

    financialReports.assignAll([
      FinancialReport(title: "رحلة 1", amount: 25.0),
      FinancialReport(title: "رحلة 2", amount: 50.0),
      FinancialReport(title: "رحلة 3", amount: 30.0),
      FinancialReport(title: "رحلة 4", amount: 45.0),
      FinancialReport(title: "رحلة 5", amount: 60.0),
      FinancialReport(title: "رحلة 6", amount: 35.0),
      FinancialReport(title: "رحلة 7", amount: 40.0),
    ]);
  }
}
