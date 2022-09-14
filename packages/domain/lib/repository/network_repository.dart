import 'package:domain/model/get_data_response.dart';

abstract class NetworkRepository {
  Future<GetDataResponse> requestMovie({
    required String apiPath,
    required Map<String, dynamic> queryParameters,
  });
}
