import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _db;

  Future<Database> get database async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'run_territory.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE run_sessions (
        id TEXT PRIMARY KEY,
        started_at INTEGER NOT NULL,
        ended_at INTEGER,
        status TEXT NOT NULL,
        distance_m REAL DEFAULT 0,
        duration_s INTEGER DEFAULT 0,
        avg_pace REAL DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE gps_points (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        session_id TEXT NOT NULL,
        lat REAL NOT NULL,
        lng REAL NOT NULL,
        altitude REAL,
        accuracy REAL,
        speed REAL,
        recorded_at INTEGER NOT NULL,
        FOREIGN KEY (session_id) REFERENCES run_sessions(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE territories (
        id TEXT PRIMARY KEY,
        owner_id TEXT NOT NULL,
        session_id TEXT,
        polygon TEXT NOT NULL,
        area_m2 REAL NOT NULL,
        color_hex TEXT NOT NULL,
        claimed_at INTEGER NOT NULL,
        FOREIGN KEY (session_id) REFERENCES run_sessions(id)
      )
    ''');

    await db.execute('CREATE INDEX idx_gps_session ON gps_points(session_id)');
    await db.execute('CREATE INDEX idx_territory_owner ON territories(owner_id)');
  }
}
