import 'package:presentation/ui/movie_page/model/movie_row_data.dart';

class MovieListTile {
  final List<MovieRowData> movieTrending;
  final List<MovieRowData> movieComing;

  const MovieListTile({
    required this.movieTrending,
    required this.movieComing,
  });

  MovieListTile copyWith({
    List<MovieRowData>? movieTrending,
    List<MovieRowData>? movieComing,
  }) =>
      MovieListTile(
        movieTrending: movieTrending ?? this.movieTrending,
        movieComing: movieComing ?? this.movieTrending,
      );

  factory MovieListTile.init() => const MovieListTile(
        movieTrending: [],
        movieComing: [],
      );
}
