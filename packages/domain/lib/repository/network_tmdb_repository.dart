import 'package:domain/entity/tmdb_people_response.dart';

abstract class NetworkTMDBRepository {
  Future<TMDBPeopleResponse> requestPeopleImages({
    required int? id,
  });
}
