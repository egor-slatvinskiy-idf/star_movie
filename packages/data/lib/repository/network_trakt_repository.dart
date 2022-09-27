import 'package:data/configuration/configuration_request.dart';
import 'package:data/configuration/query_parameters.dart';
import 'package:data/services/api_base_service.dart';
import 'package:data/services/service_payload.dart';
import 'package:domain/entity/cast_response/movie_people_response.dart';
import 'package:domain/model/get_data_response.dart';
import 'package:domain/repository/network_trakt_repository.dart';

class NetworkTraktRepositoryImpl implements NetworkTraktRepository {
  final ApiBaseService<ServicePayLoad> _apiService;

  const NetworkTraktRepositoryImpl(this._apiService);

  @override
  Future<ResponseMoviePeople> requestMoviePeople({
    required int id,
  }) async {
    final path = endPointCastTrakt(id: id);
    return _apiService.get(path: path).then(
          (value) => ResponseMoviePeople.fromJson(value.data),
        );
  }

  @override
  Future<GetDataResponse> requestMovieListTrending({
    required String? limit,
  }) async {
    return _apiService
        .get(
            path: ConfigurationRequest.endPointTrending,
            queryParameters: queryParametersMovieList(limit: limit))
        .then(
      (value) {
        return GetDataResponse(
          headers: value.headers.map,
          body: (value.data as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList(),
        );
      },
    );
  }

  @override
  Future<GetDataResponse> requestMovieListComing({
    required String? limit,
  }) async {
    return _apiService
        .get(
            path: ConfigurationRequest.endPointComing,
            queryParameters: queryParametersMovieList(limit: limit))
        .then(
      (value) {
        return GetDataResponse(
          headers: value.headers.map,
          body: (value.data as List<dynamic>)
              .map((e) => e as Map<String, dynamic>)
              .toList(),
        );
      },
    );
  }
}
