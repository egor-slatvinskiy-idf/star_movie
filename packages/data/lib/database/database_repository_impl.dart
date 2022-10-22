import 'package:data/configuration/configuration_database.dart';
import 'package:data/database/database_model/cast_model.dart';
import 'package:data/database/database_model/movie_list_model.dart';
import 'package:data/mappers/cast_mapper.dart';
import 'package:data/mappers/movie_list_mapper.dart';
import 'package:domain/entity/movie_list_response/movie_list_response.dart';
import 'package:domain/model/response_model_people.dart';
import 'package:domain/repository/database_repository.dart';
import 'package:domain/use_case/request_movie_list_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  static final DatabaseRepositoryImpl instance = DatabaseRepositoryImpl();
  final MovieListMapper _movieListMapper = MovieListMapper();
  final CastMapper _castMapper = CastMapper();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDataBase(ConfigurationDatabase.nameDb);
    return _database!;
  }

  Future<Database> initDataBase(String filePath) async {
    final dbPath = await getDatabasesPath();
    final String path = join(
      dbPath,
      filePath,
    );
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future _createDb(Database instanceDb, int version) async {
    await instanceDb.execute('''
CREATE TABLE IF NOT EXISTS ${ConfigurationDatabase.trendingList} (
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
''');
    await instanceDb.execute('''
CREATE TABLE IF NOT EXISTS ${ConfigurationDatabase.comingList} (
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
''');
    await instanceDb.execute('''
CREATE TABLE IF NOT EXISTS ${ConfigurationDatabase.castList} (
  ${ConfigurationDatabase.movieId} ${ConfigurationDatabase.intType},
  ${ConfigurationDatabase.characters} ${ConfigurationDatabase.textType},
  ${ConfigurationDatabase.person} ${ConfigurationDatabase.textType},
  ${ConfigurationDatabase.image} ${ConfigurationDatabase.textType}
  )
''');
  }

  @override
  Future insertCast(
    List<ResponseModelPeople> response,
    int movieId,
  ) async {
    final instanceDb = await instance.database;
    await instanceDb.delete(ConfigurationDatabase.castList);
    final castMovie = response
        .map((people) => CastModel.fromResponse(movieId, people))
        .toList();
    await instanceDb.transaction(
      (txn) async {
        final batch = txn.batch();
        for (var people in castMovie) {
          batch.insert(ConfigurationDatabase.castList, people.toMap());
        }
        await batch.commit();
      },
    );
  }

  @override
  Future<List<ResponseModelPeople>> readCast(int movieId) async {
    final instanceDb = await instance.database;
    final castFromDb = await instanceDb.query(
      ConfigurationDatabase.castList,
      where: '${ConfigurationDatabase.movieId} = $movieId',
    );
    return castFromDb.isEmpty ? List.empty() : _castMapper(castFromDb);
  }

  @override
  Future insertMovieList(
    List<MovieListResponse> response,
    TypeListMovie typeMovie,
  ) async {
    final instanceDb = await instance.database;
    final movieList = response
        .map(
          (e) => MovieListDB.fromResponse(e),
        )
        .toList();
    typeMovie == TypeListMovie.trending
        ? await _batchMovieListInsert(
            instanceDb,
            movieList,
            ConfigurationDatabase.trendingList,
          )
        : await _batchMovieListInsert(
            instanceDb,
            movieList,
            ConfigurationDatabase.comingList,
          );
  }

  Future<void> _batchMovieListInsert(
    Database instanceDb,
    List<MovieListDB> movieList,
    String table,
  ) async {
    await instanceDb.transaction(
      (txn) async {
        final batch = txn.batch();
        for (var movie in movieList) {
          batch.insert(table, movie.toJson());
        }
        await batch.commit();
      },
    );
  }

  @override
  Future<List<MovieListResponse>> readMovieList(TypeListMovie type) async {
    final instanceDb = await instance.database;
    final movieFromDB = type == TypeListMovie.trending
        ? await instanceDb.query(ConfigurationDatabase.trendingList)
        : await instanceDb.query(ConfigurationDatabase.comingList);
    return _movieListMapper(movieFromDB);
  }

  @override
  Future<bool> isEqualToMovieListWithDb(
    List<int?> listId,
    TypeListMovie type,
  ) async {
    final instanceDb = await instance.database;
    final movieFromDb = type == TypeListMovie.trending
        ? await instanceDb.query(ConfigurationDatabase.trendingList)
        : await instanceDb.query(ConfigurationDatabase.comingList);
    final movieIdFromDb =
        _movieListMapper(movieFromDb).map((e) => e.movie?.ids?.trakt).toList();
    return !listEquals(movieIdFromDb, listId);
  }

  @override
  Future<void> deleteMovieList(TypeListMovie typeMovie) async {
    final instanceDb = await instance.database;
    typeMovie == TypeListMovie.trending
        ? await instanceDb.delete(ConfigurationDatabase.trendingList)
        : await instanceDb.delete(ConfigurationDatabase.comingList);
  }
}
