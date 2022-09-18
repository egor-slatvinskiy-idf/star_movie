import 'package:domain/base/extension/capitalize_extension.dart';
import 'package:domain/base/extension/formatter_time_extension.dart';
import 'package:domain/base/mappers/base_mappers/mapper_base.dart';
import 'package:domain/base/mappers/mapper_image_url.dart';
import 'package:domain/entity/movie_response.dart';
import 'package:presentation/ui/movie_page/model/movie_row_data.dart';

class MapperMovieRowData extends Mapper<Movie, MovieRowData> {
  final MapperImageUrl mapperImageUrl;

  MapperMovieRowData({
    required this.mapperImageUrl,
  });

  @override
  MovieRowData call(Movie params) {
    return MovieRowData(
      ids: params.ids?.trakt,
      image: mapperImageUrl(params.ids?.imdb),
      title: params.title ?? '',
      rating: params.rating != null ? params.rating! / 2 : 0,
      genres: params.genres?.first.capitalize,
      runtime: params.runtime!.formatter,
      certification: params.certification ?? '',
    );
  }
}
