import 'package:data/configuration/base_options_configuration.dart';
import 'package:data/interceptor/interceptor.dart';
import 'package:data/repository/network_repository.dart';
import 'package:data/services/api_base_service.dart';
import 'package:data/services/service_payload.dart';
import 'package:dio/dio.dart';
import 'package:domain/repository/network_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initInjectorData() {
  _initModuleInterceptor();
  _initModuleApi();
  _initModuleRepository();
}

void _initModuleApi() {
  GetIt.instance.registerSingleton<Dio>(
    _buildMovieDio(
      GetIt.instance.get<HeaderInterceptor>(),
    ),
  );
  GetIt.instance.registerSingleton<ApiBaseService<ServicePayLoad>>(
    ApiBaseServiceImpl(
      GetIt.instance.get<Dio>(),
    ),
  );
}

void _initModuleRepository() {
  GetIt.instance.registerSingleton<NetworkRepository>(
    NetworkRepositoryImpl(
      GetIt.instance.get<ApiBaseService>(),
    ),
  );
}

void _initModuleInterceptor() {
  GetIt.instance.registerSingleton<HeaderInterceptor>(
    HeaderInterceptor(),
  );
}

Dio _buildMovieDio(Interceptor interceptor) {
  final options = BaseOptions(
    receiveTimeout: ConfigurationRequest.receiveTimeout,
    connectTimeout: ConfigurationRequest.connectTimeout,
    sendTimeout: ConfigurationRequest.sendTimeout,
    baseUrl: ConfigurationRequest.traktUrl,
  );
  final dio = Dio(options);
  dio.interceptors.add(interceptor);
  return dio;
}
