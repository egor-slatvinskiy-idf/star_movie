import 'package:domain/const/configuration.dart';
import 'package:domain/entity/cast_response/cast_response.dart';
import 'package:domain/model/response_model_people.dart';
import 'package:domain/repository/network_tmdb_repository.dart';
import 'package:domain/repository/network_trakt_repository.dart';
import 'package:domain/use_case/sample_use_case/use_case_in_out.dart';

const _maxLengthPeople = 4;

class RequestDetailsUseCase
    extends UseCaseInOut<int, Future<List<ResponseModelPeople>>> {
  final NetworkTraktRepository _networkRepositoryTrakt;
  final NetworkTMDBRepository _networkRepositoryTMDB;

  RequestDetailsUseCase(
    this._networkRepositoryTrakt,
    this._networkRepositoryTMDB,
  );

  @override
  Future<List<ResponseModelPeople>> call(int params) async {
    final responseCast = await _networkRepositoryTrakt.requestMoviePeople(
      id: params,
    );
    final cast = responseCast.cast ?? List.empty();
    final peopleLength =
        cast.length >= _maxLengthPeople ? _maxLengthPeople : cast.length;
    final necessaryCast = cast.take(peopleLength).toList();
    return await castPeopleModel(necessaryCast);
  }

  Future<List<ResponseModelPeople>> castPeopleModel(
    List<Cast> cast,
  ) async {
    return await Future.wait(
      cast.map(
        (e) async {
          final responseTMDB = await _networkRepositoryTMDB.requestPersonTMDB(
            id: e.person?.ids?.tmdb ?? 0,
          );
          return ResponseModelPeople(
            characters: e.characters?.first ?? '',
            person: e.person?.name ?? '',
            image: '${Configuration.imageTMDBUrl}'
                '${responseTMDB.profiles?.first?.filePath ?? ''}',
          );
        },
      ),
    );
  }
}
