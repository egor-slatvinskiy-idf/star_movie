import 'package:domain/entity/movie_list_response/movie_list_response.dart';
import 'package:domain/use_case/request_movie_list_use_case.dart';

class UpdateOrDeleteMovieModel {
  final List<Map<String, dynamic>> movieListFromDb;
  final List<MovieListResponse> movieListFromTrakt;
  final TypeListMovie typeListMovie;

  const UpdateOrDeleteMovieModel({
    required this.movieListFromDb,
    required this.movieListFromTrakt,
    required this.typeListMovie,
  });
}
