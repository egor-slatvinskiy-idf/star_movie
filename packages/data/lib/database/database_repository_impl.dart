import 'package:data/configuration/configuration_database.dart';
import 'package:data/database/database_model/cast_model.dart';
import 'package:data/mappers/cast_mapper.dart';
import 'package:data/services/database_service.dart';
import 'package:domain/model/response_model_people.dart';
import 'package:domain/repository/database_repository.dart';
import 'package:domain/use_case/request_movie_list_use_case.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final DatabaseService instance;
  final CastMapper castMapper;

  DatabaseRepositoryImpl(
    this.instance,
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
    final batch = instanceDb.batch();
    for (var people in castMovie) {
      batch.insert(ConfigurationDatabase.castList, people.toMap());
    }
    await batch.commit();
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

  /// MovieList database
  @override
  Future insertMovieList(
    List<Map<String, dynamic>> movieList,
    TypeListMovie typeMovie,
  ) async {
    final instanceDb = await instance.database;
    final batch = instanceDb.batch();
    for (var movie in movieList) {
      batch.insert(
        ConfigurationDatabase.movieList,
        movie,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  @override
  Future<List<Map<String, dynamic>>> readMovieList(
      TypeListMovie typeMovie) async {
    final instanceDb = await instance.database;
    final movieType = typeMovie == TypeListMovie.trending
        ? ConfigurationDatabase.movieTrending
        : ConfigurationDatabase.movieComing;
    return await instanceDb.query(
      ConfigurationDatabase.movieList,
      where: '${ConfigurationDatabase.movieType} = '
          '$movieType',
    );
  }

  @override
  Future<void> deleteMovieList(
    TypeListMovie typeMovie,
    List<dynamic> moviesId,
  ) async {
    final instanceDb = await instance.database;
    final batch = instanceDb.batch();
    for (var movieId in moviesId) {
      batch.delete(
        ConfigurationDatabase.movieList,
        where: '${ConfigurationDatabase.trakt} = $movieId',
      );
    }
    await batch.commit();
  }

  /// movie upload date database
  @override
  Future insertDateLoadMovie(
    String date,
    TypeListMovie typeMovie,
  ) async {
    final instanceDb = await instance.database;
    final movieType = typeMovie == TypeListMovie.trending
        ? ConfigurationDatabase.movieTrending
        : ConfigurationDatabase.movieComing;
    await instanceDb.insert(
      ConfigurationDatabase.dateLoad,
      {
        ConfigurationDatabase.movieType: movieType,
        ConfigurationDatabase.date: date,
      },
    );
  }

  @override
  Future updateDateLoadMovie(
    String date,
    TypeListMovie typeMovie,
  ) async {
    final instanceDb = await instance.database;
    final movieType = typeMovie == TypeListMovie.trending
        ? ConfigurationDatabase.movieTrending
        : ConfigurationDatabase.movieComing;
    await instanceDb.update(
      ConfigurationDatabase.dateLoad,
      where: '${ConfigurationDatabase.movieType} = '
          '$movieType',
      {ConfigurationDatabase.date: date},
    );
  }

  @override
  Future<DateTime?> readDateLoadMovie(
    TypeListMovie typeMovie,
  ) async {
    final instanceDb = await instance.database;
    final movieType = typeMovie == TypeListMovie.trending
        ? ConfigurationDatabase.movieTrending
        : ConfigurationDatabase.movieComing;
    final result = await instanceDb.query(
      ConfigurationDatabase.dateLoad,
      where: '${ConfigurationDatabase.movieType} = '
          '$movieType',
    );
    return result.isNotEmpty
        ? DateTime.parse(result.first[ConfigurationDatabase.date].toString())
        : null;
  }
}
