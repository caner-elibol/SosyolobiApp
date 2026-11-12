abstract final class Formatters {
  static const _months = ['Oca', 'Şub', 'Mar', 'Nis', 'May', 'Haz', 'Tem', 'Ağu', 'Eyl', 'Eki', 'Kas', 'Ara'];

  static String distanceMeters(double? meters) {
    if (meters == null) return '';
    if (meters < 1000) return '${meters.round()} m';
    return '${(meters / 1000).toStringAsFixed(1)} km';
  }

  static String eventDate(DateTime date) {
    final local = date.toLocal();
    final now = DateTime.now();
    final isToday = local.year == now.year && local.month == now.month && local.day == now.day;
    final time = '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
    if (isToday) return 'Bugün $time';
    return '${local.day} ${_months[local.month - 1]} $time';
  }

  static String eventDateLong(DateTime date) {
    final local = date.toLocal();
    final now = DateTime.now();
    final isToday = local.year == now.year && local.month == now.month && local.day == now.day;
    final time = '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
    if (isToday) return 'Bugün $time';
    return '${local.day} ${_monthsLong[local.month - 1]} $time';
  }

  static const _monthsLong = [
    'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
    'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık',
  ];

  static String time(DateTime date) {
    final local = date.toLocal();
    return '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }

  static String shortDate(DateTime date) {
    final local = date.toLocal();
    return '${local.day}.${local.month}.${local.year}';
  }

  static String dateTimeShort(DateTime date) {
    final local = date.toLocal();
    return '${local.day} ${_months[local.month - 1]} ${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }

  static String countdown(DateTime date) {
    final diff = date.difference(DateTime.now());
    if (diff.isNegative) return 'Başladı';
    final minutes = diff.inMinutes;
    final hours = diff.inHours;
    final days = diff.inDays;
    if (days > 0) {
      final restHours = hours % 24;
      return '$days gün${restHours > 0 ? ' $restHours sa' : ''} kaldı';
    }
    if (hours > 0) return '$hours sa ${minutes % 60} dk kaldı';
    return '$minutes dk kaldı';
  }
}
