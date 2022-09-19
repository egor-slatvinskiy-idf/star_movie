import 'package:json_annotation/json_annotation.dart';

part 'movie_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Movie {
  final String? title;
  final int? year;
  final Ids? ids;
  final String? tagline;
  final String? overview;
  final String? released;
  final int? runtime;
  final String? country;
  final String? trailer;
  final String? homepage;
  final String? status;
  final double? rating;
  final int? votes;
  final int? commentCount;
  final String? updatedAt;
  final String? language;
  final List<String>? availableTranslations;
  final List<String>? genres;
  final String? certification;

  Movie({
    required this.title,
    required this.year,
    required this.ids,
    required this.tagline,
    required this.overview,
    required this.released,
    required this.runtime,
    required this.country,
    required this.trailer,
    required this.homepage,
    required this.status,
    required this.rating,
    required this.votes,
    required this.commentCount,
    required this.updatedAt,
    required this.language,
    required this.availableTranslations,
    required this.genres,
    required this.certification,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Ids {
  final int? trakt;
  final String? slug;
  final String? imdb;
  final int? tmdb;

  Ids({
    required this.trakt,
    required this.slug,
    required this.imdb,
    required this.tmdb,
  });

  factory Ids.fromJson(Map<String, dynamic> json) => _$IdsFromJson(json);

  Map<String, dynamic> toJson() => _$IdsToJson(this);
}
