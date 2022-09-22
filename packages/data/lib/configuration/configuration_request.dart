class ConfigurationRequest {
  ConfigurationRequest._();

  static const receiveTimeout = 5000;
  static const connectTimeout = 5000;
  static const sendTimeout = 5000;
  static const traktUrl = 'https://api.trakt.tv/';
  static const endPointTrending = 'movies/trending';
  static const endPointComing = 'movies/anticipated';
  static const TMDBUrl = 'https://api.themoviedb.org/3/';
}
