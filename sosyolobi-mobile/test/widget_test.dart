import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sosyolobi_mobile/app.dart';

void main() {
  testWidgets('app boots without throwing', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: SosyolobiApp()));
    await tester.pump();
  });
}
