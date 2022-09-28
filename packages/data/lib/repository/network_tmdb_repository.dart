import 'package:data/configuration/query_parameters.dart';
import 'package:data/services/api_base_service.dart';
import 'package:data/services/service_payload.dart';
import 'package:domain/entity/cast_response/tmdb_people_response.dart';
import 'package:domain/repository/network_tmdb_repository.dart';

class NetworkTMDBRepositoryImpl implements NetworkTMDBRepository {
  final ApiBaseService<ServicePayLoad> _apiService;

  const NetworkTMDBRepositoryImpl(this._apiService);

  @override
  Future<TMDBPeopleResponse> requestPersonTMDB({
    required int id,
  }) async {
    final path = endPointPersonTMDB(id: id);
    return _apiService.get(path: path).then(
          (value) => TMDBPeopleResponse.fromJson(value.data),
        );
  }
}
