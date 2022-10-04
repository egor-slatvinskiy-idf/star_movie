class UserEmailPass {
  final String login;
  final String password;

  const UserEmailPass(
      this.login,
      this.password,
      );

  factory UserEmailPass.fromJson(Map<String,dynamic> json) => UserEmailPass(
    json['login'] as String,
    json['password'] as String,
  );
}