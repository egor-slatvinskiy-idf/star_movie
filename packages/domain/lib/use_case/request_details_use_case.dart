import 'package:domain/const/configuration.dart';
import 'package:domain/entity/cast_response/cast_response.dart';
import 'package:domain/model/response_model_people.dart';
import 'package:domain/repository/database_repository.dart';
import 'package:domain/repository/network_tmdb_repository.dart';
import 'package:domain/repository/network_trakt_repository.dart';
import 'package:domain/use_case/sample_use_case/use_case_in_out.dart';

const _maxLengthPeople = 4;

class RequestDetailsUseCase
    extends UseCaseInOut<int, Future<List<ResponseModelPeople>>> {
  final NetworkTraktRepository _networkRepositoryTrakt;
  final NetworkTMDBRepository _networkRepositoryTMDB;
  final DatabaseRepository _databaseRepository;

  RequestDetailsUseCase(
    this._networkRepositoryTrakt,
    this._networkRepositoryTMDB,
    this._databaseRepository,
  );

  @override
  Future<List<ResponseModelPeople>> call(int params) async {
    final castFromDb = await _databaseRepository.readCast(params);
    if (castFromDb.isNotEmpty) {
      return castFromDb;
    } else {
      final responseCast = await _networkRepositoryTrakt.requestMoviePeople(
        id: params,
      );
      final cast = responseCast.cast ?? List.empty();
      final peopleLength =
          cast.length >= _maxLengthPeople ? _maxLengthPeople : cast.length;
      final necessaryCast = cast.take(peopleLength).toList();
      final castModel = await _castPeopleModel(necessaryCast);
      await _databaseRepository.insertCast(castModel, params);
      return castModel;
    }
  }

  Future<List<ResponseModelPeople>> _castPeopleModel(
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
