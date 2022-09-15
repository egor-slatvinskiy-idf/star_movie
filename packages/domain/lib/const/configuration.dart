import 'package:domain/const/query_configuration.dart';

class Configuration {
  Configuration._();

  static const endPointTrending = 'movies/trending';
  static const endPointComing = 'movies/anticipated';
  static const pageCount = 'x-pagination-page-count';
  static const pageLimit = 'x-pagination-limit';
  static const itemCount = 'x-pagination-item-count';

  static const Map<String, dynamic> queryParameters = {
    QueryConfiguration.queryNameExtended:
        QueryConfiguration.queryConfigExtended,
    QueryConfiguration.queryNameLimit: QueryConfiguration.queryConfigLimit,
    QueryConfiguration.queryNamePage: QueryConfiguration.queryConfigPage,
  };

  static const Map<String, dynamic> queryEmpty = {};
}
