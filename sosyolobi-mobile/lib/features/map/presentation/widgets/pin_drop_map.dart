import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

const _openFreeMapStyle = 'https://tiles.openfreemap.org/styles/liberty';

class PinDropMap extends StatefulWidget {
  const PinDropMap({required this.initialCenter, required this.pin, required this.onPinSet, super.key});

  final LatLng initialCenter;
  final LatLng? pin;
  final ValueChanged<LatLng> onPinSet;

  @override
  State<PinDropMap> createState() => _PinDropMapState();
}

class _PinDropMapState extends State<PinDropMap> {
  MapLibreMapController? _controller;
  Circle? _circle;

  @override
  void didUpdateWidget(covariant PinDropMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pin != oldWidget.pin && widget.pin != null) {
      _placeCircle(widget.pin!);
    }
  }

  Future<void> _placeCircle(LatLng point) async {
    final controller = _controller;
    if (controller == null) return;
    if (_circle == null) {
      _circle = await controller.addCircle(
        CircleOptions(
          geometry: point,
          circleRadius: 10,
          circleColor: '#C2540C',
          circleStrokeWidth: 2,
          circleStrokeColor: '#ffffff',
        ),
      );
    } else {
      await controller.updateCircle(_circle!, CircleOptions(geometry: point));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: MapLibreMap(
        styleString: _openFreeMapStyle,
        initialCameraPosition: CameraPosition(target: widget.pin ?? widget.initialCenter, zoom: 12),
        onMapCreated: (controller) => _controller = controller,
        onStyleLoadedCallback: () {
          if (widget.pin != null) _placeCircle(widget.pin!);
        },
        onMapClick: (point, coordinates) {
          widget.onPinSet(coordinates);
          _placeCircle(coordinates);
        },
      ),
    );
  }
}
