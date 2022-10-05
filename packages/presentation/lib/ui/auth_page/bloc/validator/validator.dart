class Validator {
  final String login;
  final String password;

  Validator(
    this.login,
    this.password,
  );

  bool isValid() => login.isEmpty && password.isEmpty;
}
