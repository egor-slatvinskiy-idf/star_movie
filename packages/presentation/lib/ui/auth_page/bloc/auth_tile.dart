class AuthTile {
  final String? errorMessageLogin;
  final String? errorMessagePassword;

  const AuthTile({
    required this.errorMessageLogin,
    required this.errorMessagePassword,
  });

  AuthTile copyWith({
    String? errorMessageLogin,
    String? errorMessagePassword,
  }) {
    return AuthTile(
      errorMessageLogin: errorMessageLogin,
      errorMessagePassword: errorMessagePassword,
    );
  }

  factory AuthTile.init() => const AuthTile(
        errorMessageLogin: null,
        errorMessagePassword: null,
      );
}
