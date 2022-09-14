class Configuration {
  Configuration._();

  static const apiPathTrending = 'https://api.trakt.tv/movies/trending';
  static const apiPathComingSoon = 'https://api.trakt.tv/movies/anticipated';
  static const Map<String, dynamic> queryParameters = {
    'extended': 'full',
    'limit': '50'
  };
  static const Map<String, dynamic> queryEmpty = {};
}
