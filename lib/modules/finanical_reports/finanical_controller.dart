import 'package:get/get.dart';

class FinancialController extends GetxController {
  var reports = <Map<String, dynamic>>[
    {"title": "يناير", "amount": 5000.0, "date": DateTime.now().toString()},
    {"title": "فبراير", "amount": 7000.0, "date": DateTime.now().toString()},
    {"title": "مارس", "amount": 4500.0, "date": DateTime.now().toString()},
    {"title": "أبريل", "amount": 8000.0, "date": DateTime.now().toString()},
    {"title": "مايو", "amount": 9000.0, "date": DateTime.now().toString()},
    {"title": "يونيو", "amount": 6000.0, "date": DateTime.now().toString()},
    {"title": "يوليو", "amount": 7500.0, "date": DateTime.now().toString()},
  ].obs;

  void addFinancialReport(String title, double amount) {
    reports.add({
      "title": title,
      "amount": amount,
      "date": DateTime.now().toString(),
    });
  }

  void removeReport(int index) {
    reports.removeAt(index);
  }
}
