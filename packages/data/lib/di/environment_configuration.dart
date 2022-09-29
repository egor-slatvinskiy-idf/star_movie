class EnvironmentConfiguration {
  final prod = const bool.fromEnvironment("prod");
  final sandbox = const bool.fromEnvironment("sandbox");
}