import 'package:domain/entity/movie_list_response/movie_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_list_response.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class MovieListResponse {
  final int? listCount;
  final int? watchers;
  final Movie? movie;

  const MovieListResponse(
    this.listCount,
    this.watchers,
    this.movie,
  );

  factory MovieListResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieListResponseToJson(this);
}
