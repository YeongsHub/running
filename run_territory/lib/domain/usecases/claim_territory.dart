import 'package:flutter/material.dart';
import 'package:run_territory/core/constants/app_constants.dart';
import 'package:run_territory/core/utils/geo_utils.dart';
import 'package:run_territory/domain/entities/gps_point.dart';
import 'package:run_territory/domain/entities/territory.dart';
import 'package:run_territory/domain/repositories/territory_repository.dart';
import 'package:uuid/uuid.dart';

class ClaimTerritoryUseCase {
  final TerritoryRepository _repo;

  ClaimTerritoryUseCase(this._repo);

  Future<Territory?> call({
    required List<GpsPoint> path,
    required String sessionId,
    Color color = const Color(0xFF2E7D32),
  }) async {
    if (path.length < 2) return null;

    final polygon = GeoUtils.pathToEnclosedPolygon(path);
    final area = GeoUtils.calculateAreaM2(polygon);

    final existing = await _repo.getMyTerritories();
    Territory? overlapping;
    for (final t in existing) {
      if (GeoUtils.polygonsOverlap(t.polygon, polygon)) {
        overlapping = t;
        break;
      }
    }

    if (overlapping != null) {
      final merged = GeoUtils.mergePolygons(overlapping.polygon, polygon);
      final mergedArea = GeoUtils.calculateAreaM2(merged);
      final updated = overlapping.copyWith(polygon: merged, areaM2: mergedArea);
      await _repo.updateTerritory(updated);
      return updated;
    } else {
      final territory = Territory(
        id: const Uuid().v4(),
        ownerId: AppConstants.defaultUserId,
        runSessionId: sessionId,
        polygon: polygon,
        areaM2: area,
        color: color,
        claimedAt: DateTime.now(),
      );
      await _repo.saveTerritory(territory);
      return territory;
    }
  }
}
