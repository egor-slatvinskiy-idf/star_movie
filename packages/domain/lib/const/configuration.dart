class Configuration {
  final int countItem;
  Configuration._(this.countItem);

  static const endPointTrending = 'movies/trending';
  static const endPointComing = 'movies/anticipated';
  static const pageCount = 'x-pagination-page-count';
  static const nameLimit = 'limit';
  static const pageLimit = 'x-pagination-limit';
  static const itemCount = 'x-pagination-item-count';

  static const Map<String, dynamic> queryParameters = {
    'extended': 'full',
    'limit': '50',
    'page': '1',
  };

  static const Map<String, dynamic> queryEmpty = {};
}
