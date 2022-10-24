import 'package:data/configuration/configuration_database.dart';
import 'package:data/database/database_model/cast_model.dart';
import 'package:data/database/database_model/movie_list_model.dart';
import 'package:data/mappers/cast_mapper.dart';
import 'package:data/mappers/movie_list_mapper.dart';
import 'package:data/services/database_service.dart';
import 'package:domain/entity/movie_list_response/movie_list_response.dart';
import 'package:domain/model/response_model_people.dart';
import 'package:domain/repository/database_repository.dart';
import 'package:domain/use_case/request_movie_list_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final DatabaseService instance;
  final MovieListMapper movieListMapper;
  final CastMapper castMapper;

  DatabaseRepositoryImpl(
    this.instance,
    this.movieListMapper,
    this.castMapper,
  );

  /// Cast database
  @override
  Future insertCast(
    List<ResponseModelPeople> response,
    int movieId,
  ) async {
    final instanceDb = await instance.database;
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
    return castFromDb.isEmpty ? List.empty() : castMapper(castFromDb);
  }

  @override
  Future deleteCast(List<int?> moviesId) async {
    final instanceDb = await instance.database;
    await instanceDb.transaction(
      (txn) async {
        final batch = txn.batch();
        for (var movieId in moviesId) {
          batch.delete(
            ConfigurationDatabase.castList,
            where: '${ConfigurationDatabase.movieId} = $movieId',
          );
        }
        await batch.commit();
      },
    );
  }

  /// MovieList database
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
    return movieListMapper(movieFromDB);
  }

  @override
  Future<bool> isEqualToMovieListWithDb(
    List<int?> newListId,
    TypeListMovie type,
  ) async {
    final instanceDb = await instance.database;
    final movieFromDb = type == TypeListMovie.trending
        ? await instanceDb.query(ConfigurationDatabase.trendingList)
        : await instanceDb.query(ConfigurationDatabase.comingList);
    final movieIdFromDb =
        movieListMapper(movieFromDb).map((e) => e.movie?.ids?.trakt).toList();
    final differentId =
        movieIdFromDb.toSet().difference(newListId.toSet()).toList();
    await deleteCast(differentId);
    return !listEquals(movieIdFromDb, newListId);
  }

  @override
  Future<void> deleteMovieList(TypeListMovie typeMovie) async {
    final instanceDb = await instance.database;
    typeMovie == TypeListMovie.trending
        ? await instanceDb.delete(ConfigurationDatabase.trendingList)
        : await instanceDb.delete(ConfigurationDatabase.comingList);
  }
}
