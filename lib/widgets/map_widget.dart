import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapWidget extends StatelessWidget {
  final MapController controller;

  const MapWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final osmOptions = OSMOption(
      showZoomController: true,
      zoomOption: const ZoomOption(
        initZoom: 14,
        minZoomLevel: 8,
        maxZoomLevel: 19,
        stepZoom: 1.0,
      ),
      userLocationMarker: UserLocationMaker(
        personMarker: const MarkerIcon(
          icon: Icon(Icons.person_pin_circle, color: Colors.blue, size: 60),
        ),
        directionArrowMarker: const MarkerIcon(
          icon: Icon(Icons.navigation, color: Colors.red, size: 60),
        ),
      ),
      roadConfiguration: const RoadOption(roadColor: Colors.blue, roadWidth: 5),

      
      staticPoints: [
        StaticPositionGeoPoint(
          "defaultMarker",
          const MarkerIcon(
            icon: Icon(Icons.location_on, color: Colors.green, size: 60),
          ),
          [
            GeoPoint(latitude: 33.5138, longitude: 36.2765), // مثال: دمشق
          ],
        ),
      ],
    );

    return OSMFlutter(controller: controller, osmOption: osmOptions);
  }
}
