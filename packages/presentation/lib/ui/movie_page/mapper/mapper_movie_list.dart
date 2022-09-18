import 'package:domain/base/mappers/base_mappers/mapper_base.dart';
import 'package:domain/entity/movie_list_response.dart';
import 'package:presentation/ui/movie_page/mapper/mapper_movie_row_data.dart';
import 'package:presentation/ui/movie_page/model/movie_row_data.dart';

class MapperMovieList
    extends Mapper<List<MovieListResponse>, List<MovieRowData>> {
  final MapperMovieRowData mapperMovieRowData;

  MapperMovieList({
    required this.mapperMovieRowData,
  });

  @override
  List<MovieRowData> call(List<MovieListResponse> params) {
    return params
        .map(
          (e) => mapperMovieRowData(e.movie!),
        )
        .toList();
  }
}
