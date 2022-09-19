Map<String, dynamic> queryParametersMovieList({
  required String? limit,
}) {
  return {
    'extended': 'full',
    'limit': limit,
    'page': '1',
  };
}
