import 'package:data/services/api_base_service.dart';
import 'package:data/services/service_payload.dart';
import 'package:domain/model/get_data_response.dart';
import 'package:domain/repository/network_repository.dart';

class NetworkRepositoryImpl implements NetworkRepository {
  final ApiBaseService<ServicePayLoad> _apiService;

  NetworkRepositoryImpl(
    this._apiService,
  );

  @override
  Future<GetDataResponse> requestMovie({
    required String apiPath,
    required Map<String, dynamic> queryParameters,
  }) async {
    return _apiService
        .get(
      apiPath,
      queryParameters: queryParameters,
    )
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
