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
    final peopleLength = responseCast.cast!.length >= maxLengthPeople
        ? maxLengthPeople
        : responseCast.cast?.length;
    final sortedCast = responseCast.cast?.take(peopleLength ?? 0).toList();
    final List<TMDBPeopleResponse> imageTMDBList =
        await requestTMDBImage(sortedCast);
    return _mapperPeopleModel(
      responseCast.cast ?? [],
      imageTMDBList,
    );
  }

  Future<List<TMDBPeopleResponse>> requestTMDBImage(List<Cast>? cast) async {
    return await Future.wait(
      cast!.map(
        (e) async => await _networkRepositoryTMDB.requestPeopleImages(
            id: e.person?.ids?.tmdb),
      ),
    );
  }
}
