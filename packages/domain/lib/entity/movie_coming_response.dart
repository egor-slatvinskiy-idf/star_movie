import 'package:domain/entity/movie_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'movie_coming_response.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class MovieResponseComing {
  final int listCount;
  final Movie movie;

  MovieResponseComing(
      this.listCount,
      this.movie,
      );

  factory MovieResponseComing.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseComingFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseComingToJson(this);
}