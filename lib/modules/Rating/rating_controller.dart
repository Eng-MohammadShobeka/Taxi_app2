import 'package:get/get.dart';
import '../../data/models/rating.dart';

class RatingController extends GetxController {
  var ratings = <Rating>[].obs;

  // إضافة تقييم
  void addRating(Rating rating) {
    ratings.add(rating);
  }

  // احصل على تقييمات سائق معين
  List<Rating> getRatingsForDriver(String driverId) {
    return ratings.where((r) => r.driverId == driverId).toList();
  }

  // متوسط تقييم السائق
  double getAverageRating(String driverId) {
    final driverRatings = getRatingsForDriver(driverId);
    if (driverRatings.isEmpty) return 0.0;
    return driverRatings.map((r) => r.rating).reduce((a, b) => a + b) /
        driverRatings.length;
  }
}
