
import 'package:json_annotation/json_annotation.dart';
part 'tmdb_people_response.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class TMDBPeopleResponse {
  final int? id;
  final List<Profiles?>? profiles;

  TMDBPeopleResponse({
    required this.id,
    required this.profiles,
  });

  factory TMDBPeopleResponse.fromJson(dynamic json) => _$TMDBPeopleResponseFromJson(  json);

  Map<String, dynamic> toJson() => _$TMDBPeopleResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Profiles {
  final double? aspectRatio;
  final String? filePath;
  final int? height;
  final dynamic iso6391;
  final double? voteAverage;
  final int? voteCount;
  final int? width;

  Profiles({
    required this.aspectRatio,
    required this.filePath,
    required this.height,
    required this.iso6391,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  factory Profiles.fromJson(dynamic json) => _$ProfilesFromJson(json);

  Map<String, dynamic> toJson() => _$ProfilesToJson(this);
}
