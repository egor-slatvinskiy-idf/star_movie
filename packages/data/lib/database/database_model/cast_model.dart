import 'package:domain/model/response_model_people.dart';

class CastModel {
  final int? id;
  final String? characters;
  final String? person;
  final String? image;

  CastModel({
    this.id,
    this.characters,
    this.person,
    this.image,
  });

  factory CastModel.fromResponse(
    int id,
    ResponseModelPeople people,
  ) =>
      CastModel(
        id: id,
        characters: people.characters,
        person: people.person,
        image: people.image,
      );

  Map<String, dynamic> toMap() => {
        'movieId': id,
        'characters': characters,
        'person': person,
        'image': image,
      };

  static CastModel fromJson(Map<String, Object?> json) => CastModel(
        id: json['movieId'] as int?,
        characters: json['characters'] as String?,
        person: json['person'] as String?,
        image: json['image'] as String?,
      );

  ResponseModelPeople toPeopleModel() => ResponseModelPeople(
        characters: characters ?? '',
        person: person ?? '',
        image: image ?? '',
      );
}
