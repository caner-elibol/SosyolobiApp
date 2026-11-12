import 'dart:convert';

class UserTokenPayload {
  const UserTokenPayload({
    required this.sub,
    required this.role,
    this.displayName,
    required this.exp,
  });

  final String sub;
  final String role;
  final String? displayName;
  final int exp;

  bool get isExpired => DateTime.now().millisecondsSinceEpoch >= exp * 1000;

  static UserTokenPayload? tryParse(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;
      final normalized = base64Url.normalize(parts[1]);
      final payload = jsonDecode(utf8.decode(base64Url.decode(normalized))) as Map<String, dynamic>;
      final sub = payload['sub'] as String?;
      final role = payload['role'] as String?;
      final exp = payload['exp'] as int?;
      if (sub == null || role == null || exp == null) return null;
      final parsed = UserTokenPayload(
        sub: sub,
        role: role,
        displayName: payload['displayName'] as String?,
        exp: exp,
      );
      return parsed.isExpired ? null : parsed;
    } catch (_) {
      return null;
    }
  }
}
