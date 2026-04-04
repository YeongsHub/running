import 'package:sqflite/sqflite.dart';
import 'package:run_territory/data/sources/local/database_helper.dart';
import 'package:run_territory/domain/entities/friend.dart';

class FriendsLocalSource {
  final DatabaseHelper _db;
  FriendsLocalSource(this._db);

  Future<List<Friend>> getAllFriends() async {
    final db = await _db.database;
    final rows = await db.query('friends', orderBy: 'added_at DESC');
    return rows.map(Friend.fromDbMap).toList();
  }

  Future<void> upsertFriend(Friend friend) async {
    final db = await _db.database;
    await db.insert(
      'friends',
      friend.toDbMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFriend(String id) async {
    final db = await _db.database;
    await db.delete('friends', where: 'id = ?', whereArgs: [id]);
  }
}
