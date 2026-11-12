import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import '../../../../core/utils/category_icons.dart';
import '../../../activities/domain/activity.dart';
import 'activity_preview_sheet.dart';
import 'cluster_breakdown_sheet.dart';

const _openFreeMapStyle = 'https://tiles.openfreemap.org/styles/liberty';

class _MarkerGroup {
  _MarkerGroup(this.items, this.categoryName)
      : center = LatLng(
          items.map((i) => i.latitude).reduce((a, b) => a + b) / items.length,
          items.map((i) => i.longitude).reduce((a, b) => a + b) / items.length,
        );

  final List<ActivityMapItem> items;
  final String categoryName;
  final LatLng center;
}

({double x, double y}) _projectToPixel(double lng, double lat, double zoom) {
  final worldSize = 256 * math.pow(2, zoom).toDouble();
  final x = (lng + 180) / 360 * worldSize;
  final latRad = lat * math.pi / 180;
  final y = (0.5 - math.log((1 + math.sin(latRad)) / (1 - math.sin(latRad))) / (4 * math.pi)) * worldSize;
  return (x: x, y: y);
}

double _degLngPerPixel(double zoom) => 360 / (256 * math.pow(2, zoom).toDouble());

double _clusterRadius(int count) => count >= 50 ? 26.0 : (count >= 10 ? 22.0 : 18.0);

const _collisionGridPx = 46.0;
const _markerGapPx = 6.0;
const _maxSideBySide = 5;

class ActivityMapCanvas extends StatefulWidget {
  const ActivityMapCanvas({
    required this.initialCenter,
    required this.userLocation,
    required this.items,
    required this.onActivityTap,
    this.initialZoom = 12.5,
    super.key,
  });

  final LatLng initialCenter;
  final LatLng userLocation;
  final List<ActivityMapItem> items;
  final ValueChanged<ActivityMapItem> onActivityTap;
  final double initialZoom;

  @override
  State<ActivityMapCanvas> createState() => ActivityMapCanvasState();
}

class ActivityMapCanvasState extends State<ActivityMapCanvas> {
  MapLibreMapController? _controller;
  bool _ready = false;
  double _zoom = 12.5;

  Circle? _userLocationDot;
  Circle? _userLocationPulseRing;
  Timer? _pulseTimer;
  double _pulsePhase = 0;

  List<Circle> _markerCircles = [];
  List<Symbol> _clusterLabels = [];
  Map<String, _MarkerGroup> _groupsByMarkerKey = {};

  String? _selectedActivityId;

  @override
  void initState() {
    super.initState();
    _zoom = widget.initialZoom;
  }

  @override
  void didUpdateWidget(covariant ActivityMapCanvas oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.items, widget.items)) {
      _rebuildMarkers();
    }
    if (oldWidget.userLocation != widget.userLocation) {
      _updateUserLocationMarker(widget.userLocation);
    }
  }

  @override
  void dispose() {
    _pulseTimer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  Future<void> recenterOnUser() async {
    await _controller?.animateCamera(CameraUpdate.newLatLng(widget.userLocation));
  }

  @override
  Widget build(BuildContext context) {
    return MapLibreMap(
      styleString: _openFreeMapStyle,
      initialCameraPosition: CameraPosition(target: widget.initialCenter, zoom: widget.initialZoom),
      myLocationEnabled: false,
      onMapCreated: (controller) {
        _controller = controller;
        controller.onCircleTapped.add(_handleCircleTapped);
        controller.onSymbolTapped.add(_handleSymbolTapped);
      },
      onStyleLoadedCallback: () async {
        _ready = true;
        await _updateUserLocationMarker(widget.userLocation);
        await _rebuildMarkers();
      },
      onCameraIdle: _handleCameraIdle,
    );
  }

  void _handleCameraIdle() {
    final zoom = _controller?.cameraPosition?.zoom;
    if (zoom == null) return;
    if ((zoom - _zoom).abs() < 0.4) return;
    _zoom = zoom;
    _rebuildMarkers();
  }

  Future<void> _updateUserLocationMarker(LatLng point) async {
    final controller = _controller;
    if (controller == null || !_ready) return;

    if (_userLocationPulseRing == null) {
      _userLocationPulseRing = await controller.addCircle(
        CircleOptions(
          geometry: point,
          circleRadius: 14,
          circleColor: '#2563EB',
          circleOpacity: 0.28,
        ),
      );
      _startPulseAnimation();
    } else {
      await controller.updateCircle(_userLocationPulseRing!, CircleOptions(geometry: point));
    }

    if (_userLocationDot == null) {
      _userLocationDot = await controller.addCircle(
        CircleOptions(
          geometry: point,
          circleRadius: 11,
          circleColor: '#2563EB',
          circleStrokeWidth: 3,
          circleStrokeColor: '#ffffff',
        ),
      );
    } else {
      await controller.updateCircle(_userLocationDot!, CircleOptions(geometry: point));
    }
  }

  void _startPulseAnimation() {
    _pulseTimer?.cancel();
    _pulseTimer = Timer.periodic(const Duration(milliseconds: 60), (_) async {
      final controller = _controller;
      final ring = _userLocationPulseRing;
      if (controller == null || ring == null || !mounted) return;
      _pulsePhase = (_pulsePhase + 0.035) % 1.0;
      final radius = 12 + _pulsePhase * 20;
      final opacity = (1 - _pulsePhase) * 0.45;
      await controller.updateCircle(ring, CircleOptions(circleRadius: radius, circleOpacity: opacity));
    });
  }

  double _gridSizeDegrees(double zoom) {
    if (zoom >= 15) return 0;
    if (zoom >= 13) return 0.01;
    if (zoom >= 11.5) return 0.03;
    if (zoom >= 10) return 0.08;
    if (zoom >= 8) return 0.2;
    if (zoom >= 6) return 0.6;
    return 1.5;
  }

  List<_MarkerGroup> _cluster(List<ActivityMapItem> items, double zoom, String categoryName) {
    final grid = _gridSizeDegrees(zoom);
    if (grid <= 0) return [for (final item in items) _MarkerGroup([item], categoryName)];

    final buckets = <String, List<ActivityMapItem>>{};
    for (final item in items) {
      final key = '${(item.latitude / grid).round()}_${(item.longitude / grid).round()}';
      buckets.putIfAbsent(key, () => []).add(item);
    }
    return [for (final bucket in buckets.values) _MarkerGroup(bucket, categoryName)];
  }

  Future<void> _rebuildMarkers() async {
    final controller = _controller;
    if (controller == null || !_ready) return;

    if (_markerCircles.isNotEmpty) {
      await controller.removeCircles(_markerCircles);
      _markerCircles = [];
    }
    if (_clusterLabels.isNotEmpty) {
      await controller.removeSymbols(_clusterLabels);
      _clusterLabels = [];
    }

    final byCategory = <String, List<ActivityMapItem>>{};
    for (final item in widget.items) {
      byCategory.putIfAbsent(item.categoryName, () => []).add(item);
    }
    final allGroups = <_MarkerGroup>[
      for (final entry in byCategory.entries) ..._cluster(entry.value, _zoom, entry.key),
    ];

    _groupsByMarkerKey = {};
    if (allGroups.isEmpty) return;

    final circleOptions = <CircleOptions>[];
    final circleData = <Map<String, dynamic>>[];
    final symbolOptions = <SymbolOptions>[];
    final symbolData = <Map<String, dynamic>>[];
    var markerIndex = 0;

    for (final single in allGroups.where((g) => g.items.length == 1)) {
      final key = 'g${markerIndex++}';
      _groupsByMarkerKey[key] = single;
      final activity = single.items.single;
      final isSelected = activity.id == _selectedActivityId;
      circleOptions.add(
        CircleOptions(
          geometry: single.center,
          circleRadius: isSelected ? 19 : 13,
          circleColor: _hexColor(CategoryIcons.colorFor(single.categoryName)),
          circleStrokeWidth: isSelected ? 3 : 2,
          circleStrokeColor: '#ffffff',
        ),
      );
      circleData.add({'type': 'activity', 'markerKey': key});
    }

    final degLngPerPixel = _degLngPerPixel(_zoom);
    final clusters = allGroups.where((g) => g.items.length > 1).toList();
    final withPixels = [
      for (final group in clusters) (group: group, pixel: _projectToPixel(group.center.longitude, group.center.latitude, _zoom)),
    ];
    final grid = <String, List<({_MarkerGroup group, ({double x, double y}) pixel})>>{};
    for (final c in withPixels) {
      final key = '${(c.pixel.x / _collisionGridPx).round()}_${(c.pixel.y / _collisionGridPx).round()}';
      grid.putIfAbsent(key, () => []).add(c);
    }

    for (final bucket in grid.values) {
      bucket.sort((a, b) => b.group.items.length.compareTo(a.group.items.length));
      final visible = bucket.take(_maxSideBySide).toList();
      final overflow = bucket.skip(_maxSideBySide).toList();

      final widths = [for (final c in visible) _clusterRadius(c.group.items.length) * 2];
      if (overflow.isNotEmpty) widths.add(36.0);
      final totalWidth = widths.fold<double>(0, (a, b) => a + b) + _markerGapPx * (widths.length - 1);
      var cursor = -totalWidth / 2;
      final baseLatitude = bucket.first.group.center.latitude;

      for (var i = 0; i < visible.length; i++) {
        final c = visible[i];
        final w = widths[i];
        final centerOffsetPx = bucket.length > 1 ? cursor + w / 2 : 0.0;
        cursor += w + _markerGapPx;
        final position = LatLng(baseLatitude, c.group.center.longitude + centerOffsetPx * degLngPerPixel);
        final count = c.group.items.length;

        final key = 'g${markerIndex++}';
        _groupsByMarkerKey[key] = c.group;
        circleOptions.add(
          CircleOptions(
            geometry: position,
            circleRadius: _clusterRadius(count),
            circleColor: _hexColor(CategoryIcons.colorFor(c.group.categoryName)),
            circleStrokeWidth: 3,
            circleStrokeColor: '#ffffff',
            circleOpacity: 0.92,
          ),
        );
        circleData.add({'type': 'cluster', 'markerKey': key});
        symbolOptions.add(
          SymbolOptions(
            geometry: position,
            textField: '$count',
            fontNames: const ['Noto Sans Regular'],
            textSize: count >= 10 ? 14 : 13,
            textColor: '#ffffff',
          ),
        );
        symbolData.add({'type': 'cluster', 'markerKey': key});
      }

      if (overflow.isNotEmpty) {
        final w = widths.last;
        final centerOffsetPx = cursor + w / 2;
        final overflowCount = overflow.fold<int>(0, (sum, c) => sum + c.group.items.length);
        final anchor = overflow.first.group;
        final position = LatLng(baseLatitude, bucket.first.group.center.longitude + centerOffsetPx * degLngPerPixel);

        final key = 'g${markerIndex++}';
        _groupsByMarkerKey[key] = anchor;
        circleOptions.add(
          CircleOptions(
            geometry: position,
            circleRadius: 18,
            circleColor: '#081B4B',
            circleStrokeWidth: 3,
            circleStrokeColor: '#ffffff',
            circleOpacity: 0.92,
          ),
        );
        circleData.add({'type': 'cluster', 'markerKey': key});
        symbolOptions.add(
          SymbolOptions(
            geometry: position,
            textField: '+$overflowCount',
            fontNames: const ['Noto Sans Regular'],
            textSize: 12,
            textColor: '#ffffff',
          ),
        );
        symbolData.add({'type': 'cluster', 'markerKey': key});
      }
    }

    _markerCircles = await controller.addCircles(circleOptions, circleData);
    if (symbolOptions.isNotEmpty) {
      _clusterLabels = await controller.addSymbols(symbolOptions, symbolData);
    }
  }

  String _hexColor(Color color) => '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';

  void _handleCircleTapped(Circle circle) {
    final data = circle.data;
    if (data == null) return;
    _handleMarkerTapped(data);
  }

  void _handleSymbolTapped(Symbol symbol) {
    final data = symbol.data;
    if (data == null) return;
    _handleMarkerTapped(data);
  }

  void _handleMarkerTapped(Map<String, dynamic> data) {
    final markerKey = data['markerKey'] as String?;
    final group = markerKey == null ? null : _groupsByMarkerKey[markerKey];
    if (group == null || !mounted) return;

    if (group.items.length == 1) {
      _openActivitySheet(group.items.single);
    } else {
      _openClusterSheet(group);
    }
  }

  void _openActivitySheet(ActivityMapItem item) {
    setState(() => _selectedActivityId = item.id);
    _rebuildMarkers();
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => ActivityPreviewSheet(
        item: item,
        onGoToActivity: () {
          Navigator.of(context).pop();
          widget.onActivityTap(item);
        },
      ),
    ).whenComplete(() {
      if (!mounted) return;
      setState(() => _selectedActivityId = null);
      _rebuildMarkers();
    });
  }

  void _openClusterSheet(_MarkerGroup group) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => ClusterBreakdownSheet(
        categoryName: group.categoryName,
        count: group.items.length,
        onZoomIn: () {
          Navigator.of(context).pop();
          _controller?.animateCamera(CameraUpdate.newLatLngZoom(group.center, math.min(_zoom + 2.5, 17)));
        },
      ),
    );
  }
}
