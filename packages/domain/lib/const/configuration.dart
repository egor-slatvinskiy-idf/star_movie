class Configuration {
  Configuration._();

  static const endPointTrending = 'movies/trending';
  static const endPointComing = 'movies/anticipated';
  static const pageCount = 'x-pagination-page-count';
  static const pageLimit = 'x-pagination-limit';

  static const Map<String, dynamic> queryParameters = {
    'extended': 'full',
    'limit': '50'
  };
  static const Map<String, dynamic> queryEmpty = {};
}
