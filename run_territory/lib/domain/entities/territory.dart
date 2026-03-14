import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:run_territory/domain/entities/gps_point.dart';

class Territory {
  final String id;
  final String ownerId;
  final String? runSessionId;
  final List<GpsPoint> polygon;
  final double areaM2;
  final Color color;
  final DateTime claimedAt;

  const Territory({
    required this.id,
    required this.ownerId,
    this.runSessionId,
    required this.polygon,
    required this.areaM2,
    required this.color,
    required this.claimedAt,
  });

  String toGeoJsonString() {
    final coordinates = polygon.map((p) => [p.longitude, p.latitude]).toList();
    if (coordinates.isNotEmpty) coordinates.add(coordinates.first);
    return jsonEncode({
      'type': 'Polygon',
      'coordinates': [coordinates],
    });
  }

  factory Territory.fromGeoJsonString(String geoJson, {
    required String id,
    required String ownerId,
    String? runSessionId,
    required double areaM2,
    required Color color,
    required DateTime claimedAt,
  }) {
    final map = jsonDecode(geoJson) as Map<String, dynamic>;
    final coords = (map['coordinates'] as List).first as List;
    final polygon = coords.map((c) => GpsPoint(
      latitude: (c[1] as num).toDouble(),
      longitude: (c[0] as num).toDouble(),
      timestamp: claimedAt,
    )).toList();
    if (polygon.length > 1) polygon.removeLast();
    return Territory(
      id: id, ownerId: ownerId, runSessionId: runSessionId,
      polygon: polygon, areaM2: areaM2, color: color, claimedAt: claimedAt,
    );
  }

  Territory copyWith({List<GpsPoint>? polygon, double? areaM2}) {
    return Territory(
      id: id, ownerId: ownerId, runSessionId: runSessionId,
      polygon: polygon ?? this.polygon,
      areaM2: areaM2 ?? this.areaM2,
      color: color, claimedAt: claimedAt,
    );
  }
}
