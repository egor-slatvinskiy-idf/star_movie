import 'package:domain/entity/cast_response/cast_person_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cast_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Cast {
  final String? character;
  final List<String>? characters;
  final Person? person;

  const Cast({
    required this.character,
    required this.characters,
    required this.person,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);

  Map<String, dynamic> toJson() => _$CastToJson(this);
}
