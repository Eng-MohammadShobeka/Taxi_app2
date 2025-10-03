import 'package:get/get.dart';
import 'rating_controller.dart';

class RatingBinding extends Bindings {
  @override
  void dependencies() {
    // هنا يتم إنشاء أو إعادة استخدام الـ RatingController
    Get.lazyPut<RatingController>(() => RatingController());
  }
}
