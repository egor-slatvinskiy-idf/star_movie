import 'package:domain/entity/cast_response/tmdb_people_response.dart';

abstract class NetworkTMDBRepository {
  Future<TMDBPeopleResponse> requestPersonTMDB({
    required int id,
  });
}
