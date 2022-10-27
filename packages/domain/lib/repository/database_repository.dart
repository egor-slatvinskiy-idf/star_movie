import 'package:domain/model/response_model_people.dart';
import 'package:domain/use_case/request_movie_list_use_case.dart';

abstract class DatabaseRepository {
  Future insertMovieList(
    List<Map<String, dynamic>> movieList,
    TypeListMovie typeMovie,
  );

  Future<List<Map<String, dynamic>>> readMovieList(
    TypeListMovie type,
  );

  Future<void> deleteMovieList(
    TypeListMovie typeMovie,
    List<dynamic> moviesId,
  );

  Future insertCast(
    List<ResponseModelPeople> response,
    int id,
  );

  Future<List<ResponseModelPeople>> readCast(
    int movieId,
  );

  Future insertDateLoadMovie(
    String date,
    TypeListMovie movieType,
  );

  Future updateDateLoadMovie(
    String date,
    TypeListMovie typeMovie,
  );

  Future<DateTime?> readDateLoadMovie(
    TypeListMovie typeMovie,
  );
}
