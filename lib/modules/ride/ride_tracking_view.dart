import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'ride_controller.dart';

class RideTrackingView extends GetView<RideController> {
  
  RideTrackingView({super.key});

  final RideController controller = Get.put(RideController());

  @override
  Widget build(BuildContext context) {
    final startTF = TextEditingController();
    final endTF = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('تتبع الرحلة'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Search bars
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Obx(() => Column(
                  children: [
                    TextField(
                      controller: startTF,
                      decoration: const InputDecoration(
                        labelText: 'نقطة البداية',
                        prefixIcon: Icon(Icons.flag, color: Colors.green),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => controller.searchAddress(v, true),
                    ),
                    if (controller.startSuggestions.isNotEmpty)
                      Container(
                        height: 150,
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount: controller.startSuggestions.length,
                          itemBuilder: (context, i) {
                            final s = controller.startSuggestions[i];
                            return ListTile(
                              title: Text(s.displayName),
                              onTap: () {
                                startTF.text = s.displayName;
                                controller.selectAddress(s, true);
                              },
                            );
                          },
                        ),
                      ),
                  ],
                )),
                const SizedBox(height: 8),
                Obx(() => Column(
                  children: [
                    TextField(
                      controller: endTF,
                      decoration: const InputDecoration(
                        labelText: 'نقطة النهاية',
                        prefixIcon: Icon(Icons.flag, color: Colors.red),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => controller.searchAddress(v, false),
                    ),
                    if (controller.endSuggestions.isNotEmpty)
                      Container(
                        height: 150,
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount: controller.endSuggestions.length,
                          itemBuilder: (context, i) {
                            final s = controller.endSuggestions[i];
                            return ListTile(
                              title: Text(s.displayName),
                              onTap: () {
                                endTF.text = s.displayName;
                                controller.selectAddress(s, false);
                              },
                            );
                          },
                        ),
                      ),
                  ],
                )),
              ],
            ),
          ),

          // transport selector + stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
            child: Row(
              children: [
                const Text('وسيلة النقل:'),
                const SizedBox(width: 8),
                Obx(() => DropdownButton<String>(
                  value: controller.transportMode.value,
                  items: controller.transportOptions.keys.map((key) {
                    final emoji = key.contains("Bike") ? "🚴" : "🚗";
                    final label = key.replaceAll("_", " ");
                    return DropdownMenuItem(value: key, child: Text('$emoji $label'));
                  }).toList(),
                  onChanged: (v) {
                    if (v != null) controller.changeTransportMode(v);
                  },
                )),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: controller.reset,
                  icon: const Icon(Icons.refresh),
                  label: const Text('إعادة تعيين'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ),

          // stats row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('المسافة: ${controller.distance.value.toStringAsFixed(2)} كم'),
                Text('المدة: ${controller.duration.value.toStringAsFixed(1)} دقيقة'),
                Text('التكلفة: ${controller.cost.value.toStringAsFixed(2)} \$'),
              ],
            )),
          ),

          // Map
          Expanded(
            child: OSMFlutter(
              controller: controller.mapController,
              osmOption: OSMOption(
                zoomOption: const ZoomOption(initZoom: 14, minZoomLevel: 3, maxZoomLevel: 19),
                userLocationMarker: UserLocationMaker(
                  personMarker: const MarkerIcon(
                    icon: Icon(Icons.person, color: Colors.red, size: 48),
                  ),
                  directionArrowMarker: const MarkerIcon(
                    icon: Icon(Icons.navigation, color: Colors.blue, size: 48),
                  ),
                ),
                roadConfiguration: const RoadOption(roadColor: Colors.blue, roadWidth: 5),
              ),
            ),
          ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: controller.startRide,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("بدء الرحلة"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
                ElevatedButton.icon(
                  onPressed: controller.endRide,
                  icon: const Icon(Icons.stop),
                  label: const Text("إنهاء الرحلة"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
                ElevatedButton.icon(
                  onPressed: () => controller.showPaymentSheet(context),
                  icon: const Icon(Icons.payment),
                  label: const Text("الدفع"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
