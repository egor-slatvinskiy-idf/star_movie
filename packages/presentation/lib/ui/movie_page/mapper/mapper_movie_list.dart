import 'package:domain/base/extension/capitalize_extension.dart';
import 'package:domain/base/extension/formatter_time_extension.dart';
import 'package:domain/base/mappers/base_mappers/mapper_base.dart';
import 'package:domain/base/mappers/mapper_image_url.dart';
import 'package:domain/entity/movie_list_response/movie_list_response.dart';
import 'package:domain/entity/movie_list_response/movie_response.dart';
import 'package:presentation/ui/movie_page/model/movie_row_data.dart';

class MapperMovieList
    extends Mapper<List<MovieListResponse>, List<MovieRowData>> {
  final MapperImageUrl mapperImageUrl;

  MapperMovieList({
    required this.mapperImageUrl,
  });

  @override
  List<MovieRowData> call(List<MovieListResponse> params) {
    return params
        .map(
          (e) => mapperMovieRowData(e.movie!),
        )
        .toList();
  }

  MovieRowData mapperMovieRowData(Movie movie) {
    return MovieRowData(
      ids: movie.ids?.trakt ?? 0,
      image: mapperImageUrl(movie.ids?.imdb),
      title: movie.title ?? '',
      rating: movie.rating != null ? movie.rating! / 2 : 0,
      genres: movie.genres?.first.capitalize,
      runtime: movie.runtime?.formatter ?? '',
      certification: movie.certification ?? '',
      overview: movie.overview ?? '',
    );
  }
}
