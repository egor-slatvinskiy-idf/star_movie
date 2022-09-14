import 'package:data/configuration/configuration.dart';
import 'package:dio/dio.dart';

class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll(Configuration.apiKey);
    handler.next(options);
  }
}
