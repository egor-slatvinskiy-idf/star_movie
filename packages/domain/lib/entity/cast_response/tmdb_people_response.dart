import 'package:domain/entity/cast_response/tmdb_profiles_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tmdb_people_response.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class TMDBPeopleResponse {
  final int? id;
  final List<Profiles?>? profiles;

  const TMDBPeopleResponse({
    required this.id,
    required this.profiles,
  });

  factory TMDBPeopleResponse.fromJson(dynamic json) =>
      _$TMDBPeopleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TMDBPeopleResponseToJson(this);
}
