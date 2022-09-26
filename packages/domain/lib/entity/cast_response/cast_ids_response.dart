import 'package:json_annotation/json_annotation.dart';

part 'cast_ids_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Ids {
  final int? trakt;
  final String? slug;
  final String? imdb;
  final int? tmdb;
  final int? tvrage;

  const Ids({
    required this.trakt,
    required this.slug,
    required this.imdb,
    required this.tmdb,
    required this.tvrage,
  });

  factory Ids.fromJson(Map<String, dynamic> json) => _$IdsFromJson(json);

  Map<String, dynamic> toJson() => _$IdsToJson(this);
}
