Map<String, dynamic> queryParametersMovieList({
  required String? limit,
}) {
  return {
    'extended': 'full',
    'limit': limit,
    'page': '1',
  };
}

String endPointCastTrakt({
  required int? id,
}) {
  return 'movies/$id/people';
}

String endPointPersonTMDB({
  required int? id,
}) {
  return 'person/$id/images';
}
