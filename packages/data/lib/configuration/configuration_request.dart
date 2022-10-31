class ConfigurationRequest {
  ConfigurationRequest._();

  static const receiveTimeout = 5000;
  static const connectTimeout = 5000;
  static const sendTimeout = 5000;
  static const traktUrl = 'https://api.trakt.tv/';
  static const traktSandboxUrl = 'https://api-staging.trakt.tv/';
  static const endPointTrending = 'movies/trending';
  static const endPointComing = 'movies/anticipated';
  static const tMDBUrl = 'https://api.themoviedb.org/3/';
  static const sandboxJsonPath = 'environmentСonfiguration/sandbox.json';
  static const prodJsonPath = 'environmentСonfiguration/prod.json';
  static const apiKeyTrakt = 'trakt-api-key';
  static const apiKeyTMDB = 'api_key';
}
