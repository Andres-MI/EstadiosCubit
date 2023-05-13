import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapWidget extends StatelessWidget {
  final String coordinates;

  const MapWidget({super.key,
    required this.coordinates,
  });

  @override
  Widget build(BuildContext context) {
    List<String> coordinates = this.coordinates.split(',');

    return SizedBox(
      height: 200,
      width: 200,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            double.parse(coordinates[0]),
            double.parse(coordinates[1]),
          ),
          zoom: 14,
        ),
        myLocationButtonEnabled: false,
      ),
    );
  }
}
