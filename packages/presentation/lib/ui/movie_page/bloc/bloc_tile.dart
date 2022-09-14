import 'package:presentation/ui/movie_page/model/movie_row_data.dart';

enum OnTapTabBar {
  trending,
  coming,
}

class MovieTile<D> {
  final List<MovieRowData> movieTrending;
  final List<MovieRowData> movieComing;
  final OnTapTabBar onTap;

  MovieTile({
    required this.movieTrending,
    required this.movieComing,
    required this.onTap,
  });

  MovieTile<D> copyWith({
    List<MovieRowData>? movieTrending,
    List<MovieRowData>? movieComing,
    OnTapTabBar? onTap,
  }) =>
      MovieTile(
        movieTrending: movieTrending ?? this.movieTrending,
        movieComing: movieComing ?? this.movieTrending,
        onTap: onTap ?? this.onTap,
      );

  factory MovieTile.init() => MovieTile(
        movieTrending: [],
        movieComing: [],
        onTap: OnTapTabBar.trending,
      );
}
