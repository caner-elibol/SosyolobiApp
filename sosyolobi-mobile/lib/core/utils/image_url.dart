import 'package:flutter/foundation.dart' show kIsWeb;

import '../config/app_config.dart';

String? resolveImageUrl(String? url) {
  if (url == null || url.isEmpty) return url;
  if (kIsWeb) return url;

  final uri = Uri.tryParse(url);
  if (uri == null) return url;
  if (uri.host != 'localhost' && uri.host != '127.0.0.1') return url;

  final apiUri = Uri.tryParse(AppConfig.apiBaseUrl);
  if (apiUri == null || apiUri.host == uri.host) return url;

  return uri.replace(host: apiUri.host, port: apiUri.hasPort ? apiUri.port : uri.port).toString();
}

extension ResolvedNetworkImage on String? {
  String? get resolved => resolveImageUrl(this);
}
