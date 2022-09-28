# star_movie_idf

## Getting Started

In order to use this project, you need to do the following steps:
  - install all dependencies in a file pubspec.yaml;

  - install Flutter_intl plugin;
  - use command "flutter pub global run intl_utils:generate" to generate localization;

  - in the domain layer, generate json responses with the command "flutter pub run
    build_runner watch";

  - in the file "packages/data/lib/interceptor/interceptor.dart" insert and add apiKey
    for the following services:

    static const Map<String, dynamic> apiKeyTrakt = {
        'trakt-api-key':
            '{YOUR API_KEY}',
      };

    static const apiKeyOMDB = '{YOUR API_KEY}';

    static const Map<String, dynamic> apiKeyTMDB = {
      'api_key':
      'YOUR API_KEY',
    };