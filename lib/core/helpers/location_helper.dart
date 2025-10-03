import 'dart:async';
import 'dart:math' show cos, sqrt, asin;
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  /// التحقق من الصلاحيات وتشغيل خدمة الموقع
  static Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // التحقق من تفعيل GPS
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  /// جلب الموقع الحالي
  static Future<Position?> getCurrentLocation() async {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) return null;

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  /// متابعة تغير الموقع (Stream)
  static Stream<Position> getLocationStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5, // يحدث التغيير كل 5 متر
      ),
    );
  }

  /// حساب المسافة بين نقطتين (Haversine formula)
  static double calculateDistance(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) {
    const p = 0.017453292519943295; // Pi / 180
    final a =
        0.5 -
        cos((endLat - startLat) * p) / 2 +
        cos(startLat * p) *
            cos(endLat * p) *
            (1 - cos((endLng - startLng) * p)) /
            2;

    return 12742 * asin(sqrt(a)); // المسافة بالكيلومتر
  }
}
