import 'package:domain/entity/movie_people_response.dart';
import 'package:domain/model/get_data_response.dart';


abstract class NetworkTraktRepository {
  Future<GetDataResponse> requestMovieListTrending({
    required String? limit,
  });

  Future<GetDataResponse> requestMovieListComing({
    required String? limit,
  });

  Future<ResponseMoviePeople> requestMoviePeople({
    required int? id,
  });
}
