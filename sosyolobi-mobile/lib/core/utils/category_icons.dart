import 'package:flutter/material.dart';

abstract final class CategoryIcons {
  static const Map<String, IconData> _icons = {
    'Futbol': Icons.sports_soccer,
    'Basketbol': Icons.sports_basketball,
    'Voleybol': Icons.sports_volleyball,
    'Tenis': Icons.sports_tennis,
    'Koşu': Icons.directions_run,
    'Bisiklet': Icons.directions_bike,
    'Yürüyüş': Icons.terrain,
    'Kamp': Icons.cabin,
    'Kayak': Icons.downhill_skiing,
    'Masa Oyunu': Icons.casino,
    'Konser': Icons.music_note,
    'Kahve & Sosyal Buluşma': Icons.local_cafe,
    'Diğer': Icons.place,
  };

  static const Map<String, Color> _colors = {
    'Futbol': Color(0xFF2EA86F),
    'Basketbol': Color(0xFFE8740C),
    'Voleybol': Color(0xFF2563EB),
    'Tenis': Color(0xFFCA8A04),
    'Koşu': Color(0xFFDC2626),
    'Bisiklet': Color(0xFF8454D9),
    'Yürüyüş': Color(0xFF8454D9),
    'Kamp': Color(0xFFE8740C),
    'Kayak': Color(0xFF2563EB),
    'Masa Oyunu': Color(0xFFB45309),
    'Konser': Color(0xFFE94C79),
    'Kahve & Sosyal Buluşma': Color(0xFF9A3412),
    'Diğer': Color(0xFF6B7280),
  };

  static IconData iconFor(String categoryName) => _icons[categoryName] ?? Icons.place;

  static Color colorFor(String categoryName, {String? override}) {
    if (override != null && override.isNotEmpty) {
      final parsed = _tryParseHex(override);
      if (parsed != null) return parsed;
    }
    return _colors[categoryName] ?? const Color(0xFF6B7280);
  }

  static Color? _tryParseHex(String hex) {
    var value = hex.replaceFirst('#', '');
    if (value.length == 6) value = 'FF$value';
    final parsed = int.tryParse(value, radix: 16);
    return parsed == null ? null : Color(parsed);
  }
}
