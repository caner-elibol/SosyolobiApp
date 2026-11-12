enum LocationPermissionState { unknown, granted, denied, deniedForever }

class CurrentLocation {
  const CurrentLocation({
    required this.latitude,
    required this.longitude,
    required this.permissionState,
    this.isFallback = false,
  });

  const CurrentLocation.istanbulFallback({required this.permissionState})
      : latitude = 41.0082,
        longitude = 28.9784,
        isFallback = true;

  final double latitude;
  final double longitude;
  final LocationPermissionState permissionState;
  final bool isFallback;
}
