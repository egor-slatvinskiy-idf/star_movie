class JsonStore {
  final Map<String, dynamic> key;

  const JsonStore(this.key);

  String get apiKeyTrakt => key['trakt-api-key'];

  String get apiKeyTMDB => key['api_key_TMDB'];

  String get apiKeyOMDB => key['api_key_OMDB'];
}
