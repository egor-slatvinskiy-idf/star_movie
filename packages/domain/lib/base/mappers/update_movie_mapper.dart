import 'package:domain/base/mappers/base_mappers/mapper_base.dart';
import 'package:domain/base/utils/update_or_delete_movie_model.dart';
import 'package:domain/base/utils/utils.dart';
import 'package:domain/model/movie_list_database.dart';
import 'package:domain/use_case/request_movie_list_use_case.dart';

class UpdateMovieMapper
    extends Mapper<UpdateOrDeleteMovieModel, List<Map<String, dynamic>>> {
  @override
  List<Map<String, dynamic>> call(UpdateOrDeleteMovieModel params) {
    final movieListFromTrakt = params.movieListFromTrakt
        .map((movie) => MovieListDB.fromResponse(
              movie,
              movieType: params.typeListMovie == TypeListMovie.trending
                  ? Utils.trendingType
                  : Utils.comingType,
            )).toList()
        .map((e) => e.toJson()).toList();
    final selectedIds =
        params.movieListFromDb.map((e) => e[Utils.idName]).toList();
    return movieListFromTrakt
        .where((element) => !selectedIds.contains(element[Utils.idName]))
        .toList();
  }
}
