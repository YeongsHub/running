import 'package:flutter/material.dart';
import 'package:run_territory/data/sources/local/database_helper.dart';
import 'package:run_territory/domain/entities/territory.dart';
import 'package:sqflite/sqflite.dart';

class TerritoryLocalSource {
  final DatabaseHelper _dbHelper;

  TerritoryLocalSource(this._dbHelper);

  Future<void> insertTerritory(Territory territory) async {
    final db = await _dbHelper.database;
    await db.insert('territories', {
      'id': territory.id,
      'owner_id': territory.ownerId,
      'session_id': territory.runSessionId,
      'polygon': territory.toGeoJsonString(),
      'area_m2': territory.areaM2,
      'color_hex': '#${territory.color.value.toRadixString(16).padLeft(8, '0')}',
      'claimed_at': territory.claimedAt.millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateTerritory(Territory territory) async {
    final db = await _dbHelper.database;
    await db.update('territories', {
      'polygon': territory.toGeoJsonString(),
      'area_m2': territory.areaM2,
    }, where: 'id = ?', whereArgs: [territory.id]);
  }

  Future<List<Territory>> getTerritoriesByOwner(String ownerId) async {
    final db = await _dbHelper.database;
    final maps = await db.query('territories',
        where: 'owner_id = ?', whereArgs: [ownerId]);
    return maps.map((map) => Territory.fromGeoJsonString(
      map['polygon'] as String,
      id: map['id'] as String,
      ownerId: map['owner_id'] as String,
      runSessionId: map['session_id'] as String?,
      areaM2: (map['area_m2'] as num).toDouble(),
      color: Color(int.parse((map['color_hex'] as String).substring(1), radix: 16)),
      claimedAt: DateTime.fromMillisecondsSinceEpoch(map['claimed_at'] as int),
    )).toList();
  }

  Future<void> deleteTerritory(String id) async {
    final db = await _dbHelper.database;
    await db.delete('territories', where: 'id = ?', whereArgs: [id]);
  }
}
