import 'package:run_territory/domain/entities/gps_point.dart';

class GpsPointModel extends GpsPoint {
  final int? dbId;
  final String sessionId;

  const GpsPointModel({
    this.dbId,
    required this.sessionId,
    required super.latitude,
    required super.longitude,
    super.altitude,
    super.accuracy,
    super.speed,
    required super.timestamp,
  });

  Map<String, dynamic> toMap() => {
    if (dbId != null) 'id': dbId,
    'session_id': sessionId,
    'lat': latitude,
    'lng': longitude,
    'altitude': altitude,
    'accuracy': accuracy,
    'speed': speed,
    'recorded_at': timestamp.millisecondsSinceEpoch,
  };

  factory GpsPointModel.fromMap(Map<String, dynamic> map) => GpsPointModel(
    dbId: map['id'] as int?,
    sessionId: map['session_id'] as String,
    latitude: map['lat'] as double,
    longitude: map['lng'] as double,
    altitude: map['altitude'] as double?,
    accuracy: map['accuracy'] as double?,
    speed: map['speed'] as double?,
    timestamp: DateTime.fromMillisecondsSinceEpoch(map['recorded_at'] as int),
  );

  factory GpsPointModel.fromEntity(GpsPoint point, String sessionId) => GpsPointModel(
    sessionId: sessionId,
    latitude: point.latitude,
    longitude: point.longitude,
    altitude: point.altitude,
    accuracy: point.accuracy,
    speed: point.speed,
    timestamp: point.timestamp,
  );
}
