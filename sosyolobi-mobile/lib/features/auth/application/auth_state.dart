class AuthState {
  const AuthState({
    required this.isAuthenticated,
    this.userId,
    this.role,
    this.displayName,
  });

  const AuthState.unauthenticated()
      : isAuthenticated = false,
        userId = null,
        role = null,
        displayName = null;

  final bool isAuthenticated;
  final String? userId;
  final String? role;
  final String? displayName;
}
