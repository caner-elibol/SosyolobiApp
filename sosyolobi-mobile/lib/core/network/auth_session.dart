import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_session.g.dart';

@Riverpod(keepAlive: true)
class AuthSession extends _$AuthSession {
  @override
  bool build() => false;

  void setAuthenticated(bool value) => state = value;
}
