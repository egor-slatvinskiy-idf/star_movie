class ConfigurationDatabase {
  const ConfigurationDatabase._();

  static const nameDb = 'star_movie.db';
  static const trendingList = 'trendinglist';
  static const comingList = 'cominglist';
  static const castList = 'castlist';

  static const textType = 'TEXT';
  static const intType = 'INTEGER';
  static const realType = 'REAL';

  static const title = 'title';
  static const tmdb = 'tmdb';
  static const imdb = 'imdb';
  static const trakt = 'trakt';
  static const slug = 'slug';
  static const overview = 'overview';
  static const runtime = 'runtime';
  static const rating = 'rating';
  static const genres = 'genres';
  static const certification = 'certification';
  static const movieId = 'movieId';
  static const characters = 'characters';
  static const person = 'person';
  static const image = 'image';

  static String executeMovieList(String typeMovieList) {
    return '''
CREATE TABLE IF NOT EXISTS $typeMovieList (
  ${ConfigurationDatabase.title} ${ConfigurationDatabase.textType},
  ${ConfigurationDatabase.tmdb} ${ConfigurationDatabase.intType},
  ${ConfigurationDatabase.imdb} ${ConfigurationDatabase.textType},
  ${ConfigurationDatabase.trakt} ${ConfigurationDatabase.intType},
  ${ConfigurationDatabase.slug} ${ConfigurationDatabase.textType},
  ${ConfigurationDatabase.overview} ${ConfigurationDatabase.textType},
  ${ConfigurationDatabase.runtime} ${ConfigurationDatabase.intType},
  ${ConfigurationDatabase.rating} ${ConfigurationDatabase.realType},
  ${ConfigurationDatabase.genres} ${ConfigurationDatabase.textType},
  ${ConfigurationDatabase.certification} ${ConfigurationDatabase.textType}
  )
''';
  }

  static String executeMovieCast() {
    return '''
CREATE TABLE IF NOT EXISTS $castList (
  ${ConfigurationDatabase.movieId} ${ConfigurationDatabase.intType},
  ${ConfigurationDatabase.characters} ${ConfigurationDatabase.textType},
  ${ConfigurationDatabase.person} ${ConfigurationDatabase.textType},
  ${ConfigurationDatabase.image} ${ConfigurationDatabase.textType}
  )
''';
  }
}
