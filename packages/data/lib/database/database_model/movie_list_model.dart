import 'package:domain/base/extension/list_to_string_extension.dart';
import 'package:domain/base/extension/string_to_list_extension.dart';
import 'package:domain/entity/movie_list_response/ids_movie_response.dart';
import 'package:domain/entity/movie_list_response/movie_list_response.dart';
import 'package:domain/entity/movie_list_response/movie_response.dart';

class MovieListDB {
  final String? title;
  final int? tmdb;
  final String? imdb;
  final int? trakt;
  final String? slug;
  final String? overview;
  final int? runtime;
  final double? rating;
  final List<String>? genres;
  final String? certification;

  const MovieListDB({
    this.title,
    this.tmdb,
    this.imdb,
    this.trakt,
    this.slug,
    this.overview,
    this.runtime,
    this.rating,
    this.genres,
    this.certification,
  });

  factory MovieListDB.fromResponse(MovieListResponse movie) => MovieListDB(
        title: movie.movie?.title,
        tmdb: movie.movie?.ids?.tmdb,
        imdb: movie.movie?.ids?.imdb,
        trakt: movie.movie?.ids?.trakt,
        slug: movie.movie?.ids?.slug,
        overview: movie.movie?.overview,
        runtime: movie.movie?.runtime,
        rating: movie.movie?.rating,
        genres: movie.movie?.genres,
        certification: movie.movie?.certification,
      );

  static MovieListDB fromJson(Map<String, Object?> json) => MovieListDB(
        title: json['title'] as String?,
        tmdb: json['tmdb'] as int?,
        imdb: json['imdb'] as String?,
        trakt: json['trakt'] as int?,
        slug: json['slug'] as String?,
        overview: json['overview'] as String?,
        runtime: json['runtime'] as int?,
        rating: (json['rating'] as num?)?.toDouble(),
        genres: (json['genres'] as String).stringToList,
        certification: json['certification'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'tmdb': tmdb,
        'imdb': imdb,
        'trakt': trakt,
        'slug': slug,
        'overview': overview,
        'runtime': runtime,
        'rating': rating,
        'genres': genres.listToString,
        'certification': certification,
      };

  MovieListResponse toMovieList() => MovieListResponse(
        movie: Movie(
          title: title,
          ids: Ids(
            trakt: trakt,
            slug: slug,
            imdb: imdb,
            tmdb: tmdb,
          ),
          overview: overview,
          runtime: runtime,
          rating: rating,
          genres: genres,
          certification: certification,
        ),
      );
}
