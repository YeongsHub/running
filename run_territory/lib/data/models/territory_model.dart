import 'package:flutter/material.dart';
import 'package:run_territory/domain/entities/territory.dart';

class TerritoryModel extends Territory {
  const TerritoryModel({
    required super.id,
    required super.ownerId,
    super.runSessionId,
    required super.polygon,
    required super.areaM2,
    required super.color,
    required super.claimedAt,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'owner_id': ownerId,
    'session_id': runSessionId,
    'polygon': toGeoJsonString(),
    'area_m2': areaM2,
    'color_hex': '#${color.toARGB32().toRadixString(16).padLeft(8, '0')}',
    'claimed_at': claimedAt.millisecondsSinceEpoch,
  };

  factory TerritoryModel.fromMap(Map<String, dynamic> map) {
    final colorHex = (map['color_hex'] as String).replaceFirst('#', '');
    final color = Color(int.parse(colorHex, radix: 16));
    final claimedAt = DateTime.fromMillisecondsSinceEpoch(map['claimed_at'] as int);

    final territory = Territory.fromGeoJsonString(
      map['polygon'] as String,
      id: map['id'] as String,
      ownerId: map['owner_id'] as String,
      runSessionId: map['session_id'] as String?,
      areaM2: (map['area_m2'] as num).toDouble(),
      color: color,
      claimedAt: claimedAt,
    );

    return TerritoryModel(
      id: territory.id,
      ownerId: territory.ownerId,
      runSessionId: territory.runSessionId,
      polygon: territory.polygon,
      areaM2: territory.areaM2,
      color: territory.color,
      claimedAt: territory.claimedAt,
    );
  }

  factory TerritoryModel.fromEntity(Territory t) => TerritoryModel(
    id: t.id,
    ownerId: t.ownerId,
    runSessionId: t.runSessionId,
    polygon: t.polygon,
    areaM2: t.areaM2,
    color: t.color,
    claimedAt: t.claimedAt,
  );
}
