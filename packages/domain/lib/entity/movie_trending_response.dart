import 'package:domain/entity/movie_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'movie_trending_response.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class MovieTrendingResponse {
  final int watchers;
  final Movie movie;

  MovieTrendingResponse(
    this.watchers,
    this.movie,
  );

  factory MovieTrendingResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieTrendingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieTrendingResponseToJson(this);
}
