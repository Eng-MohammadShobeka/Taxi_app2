import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter/material.dart';

class SearchResult {
  final String displayName;
  final GeoPoint point;
  SearchResult(this.displayName, this.point);
  factory SearchResult.fromJson(Map<String, dynamic> j) {
    return SearchResult(
      j['display_name'] ?? '',
      GeoPoint(
        latitude: double.parse(j['lat'].toString()),
        longitude: double.parse(j['lon'].toString()),
      ),
    );
  }
}

/// نموذج بيانات الرحلة
class Ride {
  final String customerName;
  final String driverName;
  final GeoPoint start;
  final GeoPoint end;
  final double distance;
  final double price;

  Ride({
    required this.customerName,
    required this.driverName,
    required this.start,
    required this.end,
    required this.distance,
    required this.price,
  });
}

class RideController extends GetxController {
  final mapController = MapController(
    initPosition: GeoPoint(latitude: 33.5138, longitude: 36.2765),
  );

  var startPoint = Rxn<GeoPoint>();
  var endPoint = Rxn<GeoPoint>();

  var distance = 0.0.obs;
  var duration = 0.0.obs;
  var cost = 0.0.obs;

  var startSuggestions = <SearchResult>[].obs;
  var endSuggestions = <SearchResult>[].obs;

  var rideStarted = false.obs;
  var rideEnded = false.obs;

  // ✅ قائمة الرحلات القادمة
  var upcomingRides = <Ride>[].obs;

  // ✅ الرحلة الحالية
  var currentRide = Rxn<Ride>();

  // خيارات وسائط النقل مع الأسعار والسرعة التقريبية
  final transportOptions = {
    "Car_Normal": {"perKm": 1.0, "perMin": 0.3, "speedKmH": 40.0},
    "Car_Mid": {"perKm": 1.5, "perMin": 0.35, "speedKmH": 50.0},
    "Car_Luxury": {"perKm": 2.0, "perMin": 0.5, "speedKmH": 60.0},
    "Bike": {"perKm": 0.5, "perMin": 0.15, "speedKmH": 20.0},
  };

  var transportMode = "Car_Normal".obs;

  get rides => null;

  /// إضافة رحلات وهمية (للاختبار)
  void loadUpcomingRides() {
    upcomingRides.assignAll([
      Ride(
        customerName: "أحمد",
        driverName: "سائق 1",
        start: GeoPoint(latitude: 33.5102, longitude: 36.2913),
        end: GeoPoint(latitude: 33.5156, longitude: 36.2994),
        distance: 5.0,
        price: 7.5,
      ),
      Ride(
        customerName: "ليلى",
        driverName: "سائق 1",
        start: GeoPoint(latitude: 33.5202, longitude: 36.3013),
        end: GeoPoint(latitude: 33.5306, longitude: 36.3104),
        distance: 8.0,
        price: 12.0,
      ),
    ]);
  }

  /// ✅ قبول الرحلة
  void acceptRide(Ride ride) async {
    currentRide.value = ride;
    upcomingRides.remove(ride);

    startPoint.value = ride.start;
    endPoint.value = ride.end;

    await mapController.addMarker(
      ride.start,
      markerIcon: const MarkerIcon(
          icon: Icon(Icons.flag, color: Colors.green, size: 48)),
    );
    await mapController.addMarker(
      ride.end,
      markerIcon: const MarkerIcon(
          icon: Icon(Icons.flag, color: Colors.red, size: 48)),
    );

    await drawRoad();

    Get.snackbar("تم القبول ✅", "الرحلة مع ${ride.customerName}");
    Get.toNamed("/mapView"); // ✨ انتقل إلى صفحة الخريطة
  }

  /// ✅ رفض الرحلة
  void rejectRide(Ride ride) {
    upcomingRides.remove(ride);
    Get.snackbar("تم الرفض ❌", "تم رفض الرحلة مع ${ride.customerName}");
  }

  /// تغيير وسيلة النقل
  void changeTransportMode(String mode) {
    transportMode.value = mode;
    if (startPoint.value != null && endPoint.value != null) {
      drawRoad();
    }
  }

  /// البحث عن عناوين
  Future<void> searchAddress(String query, bool isStart) async {
    if (query.trim().isEmpty) {
      if (isStart)
        startSuggestions.clear();
      else
        endSuggestions.clear();
      return;
    }

    final url = Uri.https('nominatim.openstreetmap.org', '/search', {
      'q': query,
      'format': 'json',
      'addressdetails': '1',
      'limit': '6',
    });

    final res = await http.get(
      url,
      headers: {'User-Agent': 'taxi-app-example/1.0'},
    );

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      final results = data.map((e) => SearchResult.fromJson(e)).toList();
      if (isStart)
        startSuggestions.assignAll(results);
      else
        endSuggestions.assignAll(results);
    }
  }

  /// اختيار عنوان
  Future<void> selectAddress(SearchResult item, bool isStart) async {
    final point = item.point;
    if (isStart) {
      if (startPoint.value != null)
        await mapController.removeMarker(startPoint.value!);
      startPoint.value = point;
      startSuggestions.clear();
      await mapController.addMarker(
        point,
        markerIcon:
            const MarkerIcon(icon: Icon(Icons.flag, color: Colors.green, size: 48)),
      );
      await mapController.goToLocation(point);
    } else {
      if (endPoint.value != null)
        await mapController.removeMarker(endPoint.value!);
      endPoint.value = point;
      endSuggestions.clear();
      await mapController.addMarker(
        point,
        markerIcon:
            const MarkerIcon(icon: Icon(Icons.flag, color: Colors.red, size: 48)),
      );
      await mapController.goToLocation(point);
    }

    if (startPoint.value != null && endPoint.value != null) {
      await drawRoad();
    }
  }

  /// رسم الطريق وحساب المسافة والمدة والكلفة بناءً على وسيلة النقل
  Future<void> drawRoad() async {
    if (startPoint.value == null || endPoint.value == null) return;

    final roadInfo = await mapController.drawRoad(
      startPoint.value!,
      endPoint.value!,
      roadOption: const RoadOption(roadColor: Colors.blue, roadWidth: 5),
    );

    distance.value = roadInfo.distance ?? 0.0;

    final speedKmH = transportOptions[transportMode.value]?["speedKmH"] ?? 40.0;
    duration.value = distance.value / speedKmH * 60; // دقائق

    final perKm = transportOptions[transportMode.value]?["perKm"] ?? 1.0;
    final perMin = transportOptions[transportMode.value]?["perMin"] ?? 0.3;
    cost.value = (distance.value * perKm + duration.value * perMin);
  }

  /// إعادة التعيين
  Future<void> reset() async {
    if (startPoint.value != null) await mapController.removeMarker(startPoint.value!);
    if (endPoint.value != null) await mapController.removeMarker(endPoint.value!);
    await mapController.removeLastRoad();
    await mapController.clearAllRoads();

    startPoint.value = null;
    endPoint.value = null;
    distance.value = 0.0;
    duration.value = 0.0;
    cost.value = 0.0;
    startSuggestions.clear();
    endSuggestions.clear();
    rideStarted.value = false;
    rideEnded.value = false;
  }

  /// بدء الرحلة
  void startRide() {
    if (startPoint.value == null || endPoint.value == null) {
      Get.snackbar("خطأ", "يرجى تحديد نقطة البداية والنهاية أولاً");
      return;
    }
    rideStarted.value = true;
    rideEnded.value = false;
    Get.snackbar("تم البدء", "🚖 بدأت الرحلة");
  }

  /// إنهاء الرحلة
  void endRide() {
    if (!rideStarted.value) {
      Get.snackbar("خطأ", "لم تبدأ الرحلة بعد");
      return;
    }
    rideEnded.value = true;
    rideStarted.value = false;
    Get.snackbar("تم الإنهاء", "✅ انتهت الرحلة");
  }

  /// واجهة الدفع
  void showPaymentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "اختر طريقة الدفع",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.credit_card, color: Colors.blue),
                title: Text("بطاقة بنكية (\$${cost.value.toStringAsFixed(2)})"),
                onTap: () {
                  Navigator.pop(context);
                  Get.snackbar("💳 الدفع", "تم الدفع بالبطاقة");
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_balance_wallet, color: Colors.green),
                title:
                    Text("محفظة إلكترونية (\$${cost.value.toStringAsFixed(2)})"),
                onTap: () {
                  Navigator.pop(context);
                  Get.snackbar("📱 الدفع", "تم الدفع بالمحفظة");
                },
              ),
              ListTile(
                leading: const Icon(Icons.money, color: Colors.orange),
                title: Text("نقداً (\$${cost.value.toStringAsFixed(2)})"),
                onTap: () {
                  Navigator.pop(context);
                  Get.snackbar("💵 الدفع", "تم الدفع نقداً");
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
