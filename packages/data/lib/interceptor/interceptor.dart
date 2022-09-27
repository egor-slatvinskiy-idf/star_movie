import 'package:data/configuration/configuration.dart';
import 'package:dio/dio.dart';

class HeaderInterceptorTraktApi extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers.addAll(
      Configuration.apiKeyTrakt,
    );
    handler.next(options);
  }
}

class QueryParametersInterceptorTMDBApi extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.queryParameters.addAll(
      Configuration.apiKeyTMDB,
    );
    handler.next(options);
  }
}
