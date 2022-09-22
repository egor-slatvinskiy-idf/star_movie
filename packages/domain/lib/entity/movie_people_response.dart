import 'package:json_annotation/json_annotation.dart';
part 'movie_people_response.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ResponseMoviePeople {
  final List<Cast>? cast;

  ResponseMoviePeople({
    required this.cast,
  });

  factory ResponseMoviePeople.fromJson(Map<String, dynamic> json) =>
      _$ResponseMoviePeopleFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMoviePeopleToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Cast {
  final String? character;
  final List<String>? characters;
  final Person? person;

  Cast({
    required this.character,
    required this.characters,
    required this.person,
  });

  factory Cast.fromJson(Map<String, dynamic> json) =>
      _$CastFromJson(json);

  Map<String, dynamic> toJson() => _$CastToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Person {
  final String? name;
  final Ids? ids;

  Person({
    required this.name,
    required this.ids,
  });

  factory Person.fromJson(Map<String, dynamic> json) =>
      _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Ids {
  final int? trakt;
  final String? slug;
  final String? imdb;
  final int? tmdb;
  final int? tvrage;

  Ids({
    required this.trakt,
    required this.slug,
    required this.imdb,
    required this.tmdb,
    required this.tvrage,
  });

  factory Ids.fromJson(Map<String, dynamic> json) =>
      _$IdsFromJson(json);

  Map<String, dynamic> toJson() => _$IdsToJson(this);
}
