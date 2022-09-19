import 'package:domain/model/get_data_response.dart';

abstract class NetworkRepository {
  Future<GetDataResponse> requestMovieListTrending({
    required String? limit,
  });

  Future<GetDataResponse> requestMovieListComing({
    required String? limit,
  });
}
