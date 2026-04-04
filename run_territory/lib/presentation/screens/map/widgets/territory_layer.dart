import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:run_territory/domain/entities/territory.dart';

class TerritoryLayer extends StatelessWidget {
  final List<Territory> territories;
  final Color? colorOverride;

  const TerritoryLayer({super.key, required this.territories, this.colorOverride});

  @override
  Widget build(BuildContext context) {
    return PolygonLayer(
      polygons: territories.map((t) {
        final c = colorOverride ?? t.color;
        return Polygon(
          points: t.polygon.map((p) => LatLng(p.latitude, p.longitude)).toList(),
          color: c.withValues(alpha: 0.3),
          borderColor: c,
          borderStrokeWidth: 2.0,
        );
      }).toList(),
    );
  }
}
