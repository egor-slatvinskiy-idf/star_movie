import 'package:domain/entity/movie_list_response/movie_list_response.dart';
import 'package:domain/model/response_model_people.dart';
import 'package:domain/use_case/request_movie_list_use_case.dart';

abstract class DatabaseRepository {
  Future insertMovieList(
    List<MovieListResponse> response,
    TypeListMovie typeMovie,
  );

  Future<List<MovieListResponse>> readMovieList(
    TypeListMovie typeMovie,
  );

  Future<bool> isEqualToMovieListWithDb(
    List<int?> listId,
    TypeListMovie type,
  );

  Future<void> deleteMovieList(
    TypeListMovie typeMovie,
  );

  Future insertCast(
    List<ResponseModelPeople> response,
    int id,
  );

  Future<List<ResponseModelPeople>> readCast(
    int movieId,
  );
}
