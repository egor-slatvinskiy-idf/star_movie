import 'package:data/configuration/configuration_request.dart';
import 'package:data/interceptor/interceptor.dart';
import 'package:data/repository/network_tmdb_repository.dart';
import 'package:data/repository/network_trakt_repository.dart';
import 'package:data/services/api_base_service.dart';
import 'package:data/services/service_payload.dart';
import 'package:dio/dio.dart';
import 'package:domain/repository/network_tmdb_repository.dart';
import 'package:domain/repository/network_trakt_repository.dart';
import 'package:get_it/get_it.dart';

const traktApi = 'Trakt';
const traktService = 'TraktService';
const tMDBApi = 'TMDB';
const tMDBService = 'TMDBService';

void initInjectorData() {
  _initModuleInterceptor();
  _initModuleApi();
  _initModuleRepository();
}

void _initModuleApi() {
  GetIt.instance.registerFactory<Dio>(
    () => _buildMovieDioTraktApi(
      GetIt.instance.get<HeaderInterceptorTraktApi>(),
    ),
    instanceName: traktApi,
  );
  GetIt.instance.registerFactory<ApiBaseService<ServicePayLoad>>(
    () => ApiBaseServiceImpl(
      GetIt.instance.get(
        instanceName: traktApi,
      ),
    ),
    instanceName: traktService,
  );
  GetIt.instance.registerFactory<Dio>(
    () => _buildMovieDioTMDBApi(
      GetIt.instance.get<HeaderInterceptorTMDBApi>(),
    ),
    instanceName: tMDBApi,
  );

  GetIt.instance.registerFactory<ApiBaseService<ServicePayLoad>>(
    () => ApiBaseServiceImpl(
      GetIt.instance.get(
        instanceName: tMDBApi,
      ),
    ),
    instanceName: tMDBService,
  );
}

void _initModuleRepository() {
  GetIt.instance.registerFactory<NetworkTraktRepository>(
    () => NetworkTraktRepositoryImpl(
      GetIt.instance.get(
        instanceName: traktService,
      ),
    ),
  );
  GetIt.instance.registerSingleton<NetworkTMDBRepository>(
    NetworkTMDBRepositoryImpl(
      GetIt.instance.get(
        instanceName: tMDBService,
      ),
    ),
  );
}

void _initModuleInterceptor() {
  GetIt.instance.registerFactory<HeaderInterceptorTraktApi>(
    () => HeaderInterceptorTraktApi(),
  );
  GetIt.instance.registerFactory<HeaderInterceptorTMDBApi>(
    () => HeaderInterceptorTMDBApi(),
  );
}

Dio _buildMovieDioTraktApi(Interceptor interceptor) {
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

Dio _buildMovieDioTMDBApi(Interceptor interceptor) {
  final options = BaseOptions(
    receiveTimeout: ConfigurationRequest.receiveTimeout,
    connectTimeout: ConfigurationRequest.connectTimeout,
    sendTimeout: ConfigurationRequest.sendTimeout,
    baseUrl: ConfigurationRequest.TMDBUrl,
  );
  final dio = Dio(options);
  dio.interceptors.add(interceptor);
  return dio;
}
