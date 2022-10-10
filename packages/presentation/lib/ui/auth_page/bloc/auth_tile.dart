class AuthTile {
  final String errorMessage;

  const AuthTile({required this.errorMessage});

  AuthTile copyWith({
    String? errorMessage,
  }) {
    return AuthTile(
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory AuthTile.init() => const AuthTile(
        errorMessage: '',
      );
}
