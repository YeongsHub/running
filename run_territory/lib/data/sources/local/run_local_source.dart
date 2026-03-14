import 'package:sqflite/sqflite.dart';
import 'package:run_territory/data/models/gps_point_model.dart';
import 'package:run_territory/data/models/run_session_model.dart';
import 'package:run_territory/data/sources/local/database_helper.dart';

class RunLocalSource {
  final DatabaseHelper _dbHelper;

  RunLocalSource(this._dbHelper);

  Future<void> insertSession(RunSessionModel session) async {
    final db = await _dbHelper.database;
    await db.insert('run_sessions', session.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateSession(RunSessionModel session) async {
    final db = await _dbHelper.database;
    await db.update('run_sessions', session.toMap(),
        where: 'id = ?', whereArgs: [session.id]);
  }

  Future<RunSessionModel?> getSessionById(String id) async {
    final db = await _dbHelper.database;
    final maps = await db.query('run_sessions', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return RunSessionModel.fromMap(maps.first);
  }

  Future<List<RunSessionModel>> getAllSessions() async {
    final db = await _dbHelper.database;
    final maps = await db.query('run_sessions',
        where: 'status = ?', whereArgs: ['completed'],
        orderBy: 'started_at DESC');
    return maps.map(RunSessionModel.fromMap).toList();
  }

  Future<void> insertGpsPoints(List<GpsPointModel> points) async {
    final db = await _dbHelper.database;
    final batch = db.batch();
    for (final p in points) {
      batch.insert('gps_points', p.toMap());
    }
    await batch.commit(noResult: true);
  }

  Future<List<GpsPointModel>> getPointsBySession(String sessionId) async {
    final db = await _dbHelper.database;
    final maps = await db.query('gps_points',
        where: 'session_id = ?', whereArgs: [sessionId],
        orderBy: 'recorded_at ASC');
    return maps.map(GpsPointModel.fromMap).toList();
  }
}
