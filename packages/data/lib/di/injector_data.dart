import 'package:data/interceptor/interceptor.dart';
import 'package:data/repository/network_repository.dart';
import 'package:data/services/api_base_service.dart';
import 'package:data/services/service_payload.dart';
import 'package:dio/dio.dart';
import 'package:domain/repository/network_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initInjectorData() {
  _initModuleApi();
  _initModuleRepository();
}

void _initModuleApi() {
  GetIt.instance.registerSingleton<Dio>(
    _buildMovieDio(),
    instanceName: "movieDio",
  );
  GetIt.instance.registerSingleton<ApiBaseService<ServicePayLoad>>(
    ApiBaseServiceImpl(GetIt.instance.get(instanceName: "movieDio")),
    instanceName: "movieService",
  );
}

void _initModuleRepository() {
  GetIt.instance.registerSingleton<NetworkRepository>(
    NetworkRepositoryImpl(
      GetIt.instance.get<ApiBaseService>(instanceName: "movieService"),
    ),
  );
}

Dio _buildMovieDio() {
  final options = BaseOptions();
  final dio = Dio(options);
  dio.interceptors.add(HeaderInterceptor());
  return dio;
}
