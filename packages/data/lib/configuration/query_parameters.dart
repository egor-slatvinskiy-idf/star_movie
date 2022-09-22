Map<String, dynamic> queryParametersMovieList({
  required String? limit,
}) {
  return {
    'extended': 'full',
    'limit': limit,
    'page': '1',
  };
}

String endPointDetails({
  required int? id,
}) {
  return 'movies/$id/people';
}

String endPointTMDBPeople({
  required int? id,
}) {
  return 'person/$id/images';
}
