import 'package:json_annotation/json_annotation.dart';
part 'tmdb_profiles_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Profiles {
  final double? aspectRatio;
  final String? filePath;
  final int? height;
  final double? voteAverage;
  final int? voteCount;
  final int? width;

  const Profiles({
    required this.aspectRatio,
    required this.filePath,
    required this.height,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  factory Profiles.fromJson(Map<String, dynamic> json) => _$ProfilesFromJson(json);

  Map<String, dynamic> toJson() => _$ProfilesToJson(this);
}
