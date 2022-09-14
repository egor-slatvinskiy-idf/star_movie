import 'package:domain/entity/movie_response.dart';

class MovieRowData {
  final String title;
  final double rating;
  final String genres;
  final String runtime;
  final String? certification;
  final String image;
  final int? ids;

  MovieRowData({
    required this.image,
    required this.title,
    required this.rating,
    required this.genres,
    required this.runtime,
    required this.certification,
    required this.ids,
  });

  factory MovieRowData.fromMovieListResponse(Movie movie) {
    String capitalize(String s) {
      return s[0].toUpperCase() + s.substring(1).toLowerCase();
    }

    String formatter(int minutes) {
      var duration = Duration(minutes: minutes);
      List<String> parts = duration.toString().split(':');
      return '${parts[0].padLeft(2, '')}h ${parts[1].padLeft(2, '0')}m';
    }

    return MovieRowData(
      ids: movie.ids?.trakt,
      image: movie.imageUrl ?? '',
      title: movie.title ?? '',
      rating: movie.rating != null ? movie.rating! / 2 : 0,
      genres: capitalize(movie.genres!.first),
      runtime: formatter(movie.runtime!),
      certification: movie.certification ?? '',
    );
  }
}
