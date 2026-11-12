import 'dart:async';

import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'poll_ticker.g.dart';

@Riverpod(keepAlive: true)
Stream<int> pollTicker(Ref ref) {
  return Stream<int>.periodic(const Duration(seconds: 5), (tick) => tick);
}
