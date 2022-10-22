import 'package:data/database/database_model/movie_list_model.dart';
import 'package:domain/base/mappers/base_mappers/mapper_base.dart';
import 'package:domain/entity/movie_list_response/movie_list_response.dart';

class MovieListMapper
    extends Mapper<List<Map<String, Object?>>, List<MovieListResponse>> {
  @override
  List<MovieListResponse> call(List<Map<String, Object?>> params) => params
      .map((json) => MovieListDB.fromJson(json)).toList()
      .map((e) => e.toMovieList()).toList();
}
