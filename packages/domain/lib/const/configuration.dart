class Configuration {
  const Configuration._();

  static String imageUrl(String apiKeyOMDB) =>
      'http://img.omdbapi.com/?apikey=$apiKeyOMDB=';
  static const pageCount = 'x-pagination-page-count';
  static const pageLimit = 'x-pagination-limit';
  static const itemCount = 'x-pagination-item-count';
  static const queryConfigLimit = '50';
  static const imageTMDBUrl = 'https://image.tmdb.org/t/p/original';
}
