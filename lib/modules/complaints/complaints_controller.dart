import 'package:get/get.dart';

class ComplaintsController extends GetxController {
  var complaints = <Map<String, dynamic>>[
    {"user": "أحمد", "message": "تأخير الرحلة", "resolved": false},
    {"user": "سارة", "message": "سلوك السائق غير مهذب", "resolved": false},
    {"user": "ليلى", "message": "مشكلة في الدفع", "resolved": false},
    {"user": "يوسف", "message": "إلغاء الرحلة فجأة", "resolved": false},
    {"user": "هدى", "message": "المركبة غير نظيفة", "resolved": false},
    {"user": "علي", "message": "السائق أخذ طريق أطول", "resolved": false},
    {"user": "مريم", "message": "تأخير الوصول", "resolved": false},
  ].obs;

  void addComplaint(String user, String message) {
    complaints.add({
      "user": user,
      "message": message,
      "resolved": false,
    });
  }

  void resolveComplaint(int index) {
    complaints[index]['resolved'] = true;
    complaints.refresh();
  }
}
