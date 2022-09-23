import 'package:domain/base/mappers/base_mappers/mapper_base_two_in.dart';
import 'package:domain/const/configuration.dart';
import 'package:domain/entity/movie_people_response.dart';
import 'package:domain/entity/tmdb_people_response.dart';
import 'package:domain/model/response_model_people.dart';

class MapperPeopleModel extends MapperTwoIn<List<Cast>,
    List<TMDBPeopleResponse>, List<ResponseModelPeople>> {
  @override
  List<ResponseModelPeople> call(
    List<Cast> params,
    List<TMDBPeopleResponse> twoParams,
  ) {
    return twoParams.map(
      (e) {
        final Cast person = params.first;
        return ResponseModelPeople(
          characters: person.characters?.first,
          person: person.person?.name,
          image: '${Configuration.imageTMDBUrl}'
                 '${e.profiles?.first?.filePath}',
        );
      },
    ).toList();
  }
}