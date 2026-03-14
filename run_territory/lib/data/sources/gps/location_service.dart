import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:run_territory/domain/entities/gps_point.dart';

class LocationService {
  StreamController<GpsPoint>? _controller;
  StreamSubscription<Position>? _sub;

  Stream<GpsPoint> get positionStream {
    _controller ??= StreamController<GpsPoint>.broadcast();
    return _controller!.stream;
  }

  Future<bool> requestPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return false;
    }
    if (permission == LocationPermission.deniedForever) return false;
    return true;
  }

  Future<void> startTracking() async {
    final granted = await requestPermission();
    if (!granted) return;

    _sub?.cancel();
    const settings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5,
    );
    _sub = Geolocator.getPositionStream(locationSettings: settings).listen((pos) {
      _controller?.add(GpsPoint(
        latitude: pos.latitude,
        longitude: pos.longitude,
        altitude: pos.altitude,
        accuracy: pos.accuracy,
        speed: pos.speed,
        timestamp: pos.timestamp,
      ));
    });
  }

  void stopTracking() {
    _sub?.cancel();
    _sub = null;
  }

  Future<GpsPoint?> getCurrentPosition() async {
    final granted = await requestPermission();
    if (!granted) return null;
    final pos = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
    return GpsPoint(
      latitude: pos.latitude,
      longitude: pos.longitude,
      altitude: pos.altitude,
      accuracy: pos.accuracy,
      speed: pos.speed,
      timestamp: pos.timestamp,
    );
  }

  void dispose() {
    _sub?.cancel();
    _controller?.close();
  }
}
