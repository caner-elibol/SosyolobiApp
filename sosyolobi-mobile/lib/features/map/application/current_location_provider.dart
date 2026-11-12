import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/current_location.dart';

part 'current_location_provider.g.dart';

const _cacheKey = 'last_known_location';
const _cacheTtl = Duration(minutes: 10);

@riverpod
class CurrentLocationNotifier extends _$CurrentLocationNotifier {
  @override
  Future<CurrentLocation> build() async {
    final cached = await _readCache();
    if (cached != null) {
      Future.microtask(_resolveAndCache);
      return cached;
    }
    return _resolveAndCache();
  }

  Future<void> refresh() async {
    state = const AsyncLoading<CurrentLocation>();
    state = await AsyncValue.guard(_resolveAndCache);
  }

  Future<CurrentLocation> _resolveAndCache() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      final result = CurrentLocation.istanbulFallback(
        permissionState: permission == LocationPermission.deniedForever
            ? LocationPermissionState.deniedForever
            : LocationPermissionState.denied,
      );
      state = AsyncData(result);
      return result;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 8),
        ),
      );
      final result = CurrentLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        permissionState: LocationPermissionState.granted,
      );
      await _writeCache(result);
      state = AsyncData(result);
      return result;
    } catch (_) {
      final result = const CurrentLocation.istanbulFallback(permissionState: LocationPermissionState.granted);
      state = AsyncData(result);
      return result;
    }
  }

  Future<CurrentLocation?> _readCache() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_cacheKey);
    if (raw == null) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      final timestamp = DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int);
      if (DateTime.now().difference(timestamp) > _cacheTtl) return null;
      return CurrentLocation(
        latitude: map['lat'] as double,
        longitude: map['lng'] as double,
        permissionState: LocationPermissionState.granted,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> _writeCache(CurrentLocation location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _cacheKey,
      jsonEncode({
        'lat': location.latitude,
        'lng': location.longitude,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      }),
    );
  }
}
