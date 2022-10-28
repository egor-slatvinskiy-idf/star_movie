import 'package:data/configuration/configuration_request.dart';
import 'package:data/di/json_store.dart';
import 'package:dio/dio.dart';

class HeaderInterceptorTraktApi extends Interceptor {
  final JsonStore jsonStore;

  HeaderInterceptorTraktApi(this.jsonStore);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers
        .addAll({ConfigurationRequest.apiKeyTrakt: jsonStore.apiKeyTrakt});
    handler.next(options);
  }
}

class SandboxHeaderInterceptorTraktApi extends Interceptor {
  final JsonStore jsonStore;

  SandboxHeaderInterceptorTraktApi(this.jsonStore);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers
        .addAll({ConfigurationRequest.apiKeyTrakt: jsonStore.apiKeyTrakt});
    handler.next(options);
  }
}

class QueryParametersInterceptorTMDBApi extends Interceptor {
  final JsonStore jsonStore;

  QueryParametersInterceptorTMDBApi(this.jsonStore);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.queryParameters
        .addAll({ConfigurationRequest.apiKeyTMDB: jsonStore.apiKeyTMDB});
    handler.next(options);
  }
}
