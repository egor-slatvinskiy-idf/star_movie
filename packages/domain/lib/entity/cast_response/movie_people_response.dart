import 'package:domain/entity/cast_response/cast_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'movie_people_response.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ResponseMoviePeople {
  final List<Cast>? cast;

  const ResponseMoviePeople({
    required this.cast,
  });

  factory ResponseMoviePeople.fromJson(Map<String, dynamic> json) =>
      _$ResponseMoviePeopleFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMoviePeopleToJson(this);
}


