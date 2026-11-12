import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/auth_session.dart';
import '../data/auth_api.dart';
import '../domain/user_token_payload.dart';
import 'auth_state.dart';

part 'auth_notifier.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<AuthState> build() async {
    ref.listen(authSessionProvider, (previous, isAuthenticated) {
      if (isAuthenticated == false && state.value?.isAuthenticated == true) {
        state = const AsyncData(AuthState.unauthenticated());
      }
    });

    return _restoreFromStorage();
  }

  Future<AuthState> _restoreFromStorage() async {
    final token = await ref.read(tokenStorageProvider).readAccessToken();
    final payload = token == null ? null : UserTokenPayload.tryParse(token);
    final authenticated = payload != null;
    ref.read(authSessionProvider.notifier).setAuthenticated(authenticated);
    if (payload == null) return const AuthState.unauthenticated();
    return AuthState(
      isAuthenticated: true,
      userId: payload.sub,
      role: payload.role,
      displayName: payload.displayName,
    );
  }

  Future<void> sendOtp(String phoneNumber) => ref.read(authApiProvider).sendOtp(phoneNumber);

  Future<void> verifyOtp({required String phoneNumber, required String code}) async {
    final auth = await ref.read(authApiProvider).verifyOtp(phoneNumber: phoneNumber, code: code);
    await ref.read(tokenStorageProvider).save(
          accessToken: auth.accessToken,
          refreshToken: auth.refreshToken,
        );
    ref.read(authSessionProvider.notifier).setAuthenticated(true);
    state = AsyncData(
      AuthState(
        isAuthenticated: true,
        userId: auth.userId,
        role: auth.role,
        displayName: auth.displayName,
      ),
    );
  }

  Future<void> logout() async {
    final storage = ref.read(tokenStorageProvider);
    final refreshToken = await storage.readRefreshToken();
    if (refreshToken != null) {
      try {
        await ref.read(authApiProvider).logout(refreshToken);
      } on ApiException {
        // Best-effort — still clear local state even if the server call fails.
      }
    }
    await storage.clear();
    ref.read(authSessionProvider.notifier).setAuthenticated(false);
    state = const AsyncData(AuthState.unauthenticated());
  }
}
