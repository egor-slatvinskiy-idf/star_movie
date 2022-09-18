import 'package:domain/model/get_data_response.dart';

abstract class NetworkRepository {
  Future<GetDataResponse> requestMovieListTrending({
    required Map<String, dynamic> queryParameters,
  });

  Future<GetDataResponse> requestMovieListComing({
    required Map<String, dynamic> queryParameters,
  });
}
