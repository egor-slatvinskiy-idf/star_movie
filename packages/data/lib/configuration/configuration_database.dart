class ConfigurationDatabase {
  const ConfigurationDatabase._();

  static const nameDb = 'star_movie.db';
  static const movieList = 'movielist';
  static const castList = 'castlist';
  static const dateLoad = 'dateload';

  static const textType = 'TEXT';
  static const intType = 'INTEGER';
  static const intPrimaryType = 'INTEGER PRIMARY KEY';
  static const realType = 'REAL';

  static const movieType = 'type';
  static const movieTrending = 1;
  static const movieComing = 2;
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
  static const date = 'date';

  static String executeCreateMovieList() {
    return '''
CREATE TABLE IF NOT EXISTS $movieList (
  ${ConfigurationDatabase.movieType} ${ConfigurationDatabase.intType},
  ${ConfigurationDatabase.title} ${ConfigurationDatabase.textType},
  ${ConfigurationDatabase.tmdb} ${ConfigurationDatabase.intType},
  ${ConfigurationDatabase.imdb} ${ConfigurationDatabase.textType},
  ${ConfigurationDatabase.trakt} ${ConfigurationDatabase.intPrimaryType},
  ${ConfigurationDatabase.slug} ${ConfigurationDatabase.textType},
  ${ConfigurationDatabase.overview} ${ConfigurationDatabase.textType},
  ${ConfigurationDatabase.runtime} ${ConfigurationDatabase.intType},
  ${ConfigurationDatabase.rating} ${ConfigurationDatabase.realType},
  ${ConfigurationDatabase.genres} ${ConfigurationDatabase.textType},
  ${ConfigurationDatabase.certification} ${ConfigurationDatabase.textType}
  )
''';
  }

  static String executeCreateMovieCast() {
    return '''
CREATE TABLE IF NOT EXISTS $castList (
  ${ConfigurationDatabase.characters} ${ConfigurationDatabase.textType},
  ${ConfigurationDatabase.person} ${ConfigurationDatabase.textType},
  ${ConfigurationDatabase.image} ${ConfigurationDatabase.textType},
  ${ConfigurationDatabase.movieId} ${ConfigurationDatabase.intType},
  FOREIGN KEY ($movieId) REFERENCES $movieList($trakt) ON DELETE CASCADE
  )
''';
  }

  static String executeCreateDateLoad() {
    return '''
CREATE TABLE IF NOT EXISTS $dateLoad (
  ${ConfigurationDatabase.movieType} ${ConfigurationDatabase.intType},
  ${ConfigurationDatabase.date} ${ConfigurationDatabase.textType}
  )
''';
  }
}
