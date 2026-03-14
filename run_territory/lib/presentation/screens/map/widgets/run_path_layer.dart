import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:run_territory/domain/entities/gps_point.dart';

class RunPathLayer extends StatelessWidget {
  final List<GpsPoint> path;

  const RunPathLayer({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    if (path.length < 2) return const SizedBox.shrink();
    return PolylineLayer(
      polylines: [
        Polyline(
          points: path.map((p) => LatLng(p.latitude, p.longitude)).toList(),
          strokeWidth: 4.0,
          color: Colors.blue,
        ),
      ],
    );
  }
}
