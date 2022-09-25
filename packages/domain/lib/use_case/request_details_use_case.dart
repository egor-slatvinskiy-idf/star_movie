import 'package:domain/base/mappers/mapper_people_model.dart';
import 'package:domain/entity/movie_people_response.dart';
import 'package:domain/entity/tmdb_people_response.dart';
import 'package:domain/model/response_model_people.dart';
import 'package:domain/repository/network_tmdb_repository.dart';
import 'package:domain/repository/network_trakt_repository.dart';
import 'package:domain/use_case/sample_use_case/use_case_in_out.dart';

const maxLengthPeople = 4;

class RequestDetailsUseCase
    extends UseCaseInOut<int, Future<List<ResponseModelPeople>>> {
  final NetworkTraktRepository _networkRepositoryTrakt;
  final NetworkTMDBRepository _networkRepositoryTMDB;
  final MapperPeopleModel _mapperPeopleModel;

  RequestDetailsUseCase(
    this._networkRepositoryTrakt,
    this._networkRepositoryTMDB,
    this._mapperPeopleModel,
  );

  @override
  Future<List<ResponseModelPeople>> call(int params) async {
    final responseCast = await _networkRepositoryTrakt.requestMoviePeople(
      id: params,
    );
    final cast = responseCast.cast ?? List.empty();
    final peopleLength =
        cast.length >= maxLengthPeople ? maxLengthPeople : cast.length;
    final sortedCast = cast.take(peopleLength).toList();
    final List<TMDBPeopleResponse> responseTMDBPerson =
        await requestTMDBImage(sortedCast);
    return _mapperPeopleModel(
      cast,
      responseTMDBPerson,
    );
  }

  Future<List<TMDBPeopleResponse>> requestTMDBImage(
    List<Cast> cast,
  ) async {
    return await Future.wait(
      cast.map(
        (e) async => await _networkRepositoryTMDB.requestPersonTMDB(
          id: e.person?.ids?.tmdb ?? 0,
        ),
      ),
    );
  }
}
