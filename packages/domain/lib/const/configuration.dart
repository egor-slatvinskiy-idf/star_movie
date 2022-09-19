import 'package:domain/const/api_key.dart';

class Configuration {
  Configuration._();

  static const imageUrl =
      'http://img.omdbapi.com/?apikey=${ApiKey.apiKeyOMDB}=';
  static const pageCount = 'x-pagination-page-count';
  static const pageLimit = 'x-pagination-limit';
  static const itemCount = 'x-pagination-item-count';
  static const queryConfigLimit = '50';
}
