import 'package:data/configuration/configuration.dart';
import 'package:dio/dio.dart';

class HeaderInterceptorTraktApi extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll(Configuration.apiKey);
    handler.next(options);
  }
}

class HeaderInterceptorTMDBApi extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll(Configuration.apiKeyTMDB);
    handler.next(options);
  }
}
