import 'package:domain/entity/cast_response/cast_ids_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cast_person_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Person {
  final String? name;
  final Ids? ids;

  const Person({
    required this.name,
    required this.ids,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
