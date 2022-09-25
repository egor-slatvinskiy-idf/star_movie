import 'package:domain/entity/tmdb_people_response.dart';

abstract class NetworkTMDBRepository {
  Future<TMDBPeopleResponse> requestPersonTMDB({
    required int id,
  });
}
