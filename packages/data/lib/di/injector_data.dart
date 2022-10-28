import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/configuration/configuration_request.dart';
import 'package:data/database/database_repository_impl.dart';
import 'package:data/di/environment_configuration.dart';
import 'package:data/di/json_store.dart';
import 'package:data/di/read_json_store.dart';
import 'package:data/interceptor/interceptor.dart';
import 'package:data/mappers/cast_mapper.dart';
import 'package:data/repository/auth_repository.dart';
import 'package:data/repository/network_tmdb_repository.dart';
import 'package:data/repository/network_trakt_repository.dart';
import 'package:data/repository/preferences_local_repository.dart';
import 'package:data/services/analytics_service_impl.dart';
import 'package:data/services/api_base_service.dart';
import 'package:data/services/database_service.dart';
import 'package:data/services/service_payload.dart';
import 'package:dio/dio.dart';
import 'package:domain/base/mappers/movie_list_mapper.dart';
import 'package:domain/repository/api_key_repository.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/repository/database_repository.dart';
import 'package:domain/repository/network_tmdb_repository.dart';
import 'package:domain/repository/network_trakt_repository.dart';
import 'package:domain/repository/preferences_local_repository.dart';
import 'package:domain/services/analytics_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _traktApi = 'Trakt';
const _traktService = 'TraktService';
const _tMDBApi = 'TMDB';
const _tMDBService = 'TMDBService';

Future<void> initInjectorData() async {
  await _initModuleJsonStore();
  _initModuleInterceptor();
  _initModuleApi();
  _initFirebaseAnalytics();
  _initModuleRepository();
  _initModuleMappers();
}

void _initModuleApi() {
  final environmentConfiguration = EnvironmentConfiguration();
  if (environmentConfiguration.prod) {
    GetIt.instance.registerSingleton<Dio>(
      _buildMovieDioTraktApi(
        GetIt.instance.get<HeaderInterceptorTraktApi>(),
      ),
      instanceName: _traktApi,
    );
  } else if (environmentConfiguration.sandbox) {
    GetIt.instance.registerSingleton<Dio>(
      _buildSandboxMovieDioTraktApi(
        GetIt.instance.get<SandboxHeaderInterceptorTraktApi>(),
      ),
      instanceName: _traktApi,
    );
  }

  GetIt.instance.registerSingleton<ApiBaseService<ServicePayLoad>>(
    ApiBaseServiceImpl(
      GetIt.instance.get(
        instanceName: _traktApi,
      ),
    ),
    instanceName: _traktService,
  );

  GetIt.instance.registerSingleton<Dio>(
    _buildMovieDioTMDBApi(
      GetIt.instance.get<QueryParametersInterceptorTMDBApi>(),
    ),
    instanceName: _tMDBApi,
  );

  GetIt.instance.registerSingleton<ApiBaseService<ServicePayLoad>>(
    ApiBaseServiceImpl(
      GetIt.instance.get(
        instanceName: _tMDBApi,
      ),
    ),
    instanceName: _tMDBService,
  );
  GetIt.instance.registerSingleton<DatabaseService>(
    DatabaseService(),
  );
}

void _initModuleRepository() async {
  GetIt.instance.registerSingleton<NetworkTraktRepository>(
    NetworkTraktRepositoryImpl(
      GetIt.instance.get(
        instanceName: _traktService,
      ),
    ),
  );
  GetIt.instance.registerSingleton<NetworkTMDBRepository>(
    NetworkTMDBRepositoryImpl(
      GetIt.instance.get(
        instanceName: _tMDBService,
      ),
    ),
  );
  GetIt.instance.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      FirebaseAuth.instance,
      FirebaseFirestore.instance,
    ),
  );
  GetIt.instance.registerSingleton(
    await SharedPreferences.getInstance(),
  );
  GetIt.instance.registerLazySingleton<PreferencesLocalRepository>(
    () => PreferencesLocalRepositoryImpl(
      sharedPreferences: GetIt.instance.get(),
    ),
  );
  GetIt.instance.registerSingleton<DatabaseRepository>(
    DatabaseRepositoryImpl(
      GetIt.instance.get<DatabaseService>(),
      GetIt.instance.get<CastMapper>(),
    ),
  );
}

void _initModuleMappers() {
  GetIt.instance.registerFactory<MovieListMapper>(
    () => MovieListMapper(),
  );
  GetIt.instance.registerFactory<CastMapper>(
    () => CastMapper(),
  );
}

void _initFirebaseAnalytics() {
  GetIt.instance.registerSingleton<AnalyticsService>(
    AnalyticsServiceImpl(FirebaseAnalytics.instance),
  );
}

Future<void> _initModuleJsonStore() async {
  final environmentConfiguration = EnvironmentConfiguration();
  final readJsonStore = await ReadJsonStore(
          path: environmentConfiguration.prod
              ? ConfigurationRequest.prodJsonPath
              : environmentConfiguration.sandbox
                  ? ConfigurationRequest.sandboxJsonPath
                  : '')
      .read();
  GetIt.instance.registerLazySingleton<JsonStore>(
    () => JsonStore(readJsonStore),
  );
  GetIt.instance.registerFactory<String>(
    () => JsonStore(readJsonStore).apiKeyOMDB,
    instanceName: ApiKeyRepository.apiKeyOMDB,
  );
}

void _initModuleInterceptor() {
  final environmentConfiguration = EnvironmentConfiguration();
  if (environmentConfiguration.prod) {
    GetIt.instance.registerSingleton<HeaderInterceptorTraktApi>(
      HeaderInterceptorTraktApi(
        GetIt.instance.get<JsonStore>(),
      ),
    );
  } else if (environmentConfiguration.sandbox) {
    GetIt.instance.registerSingleton<SandboxHeaderInterceptorTraktApi>(
      SandboxHeaderInterceptorTraktApi(
        GetIt.instance.get<JsonStore>(),
      ),
    );
  }

  GetIt.instance.registerSingleton<QueryParametersInterceptorTMDBApi>(
    QueryParametersInterceptorTMDBApi(
      GetIt.instance.get<JsonStore>(),
    ),
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

Dio _buildSandboxMovieDioTraktApi(Interceptor interceptor) {
  final options = BaseOptions(
    receiveTimeout: ConfigurationRequest.receiveTimeout,
    connectTimeout: ConfigurationRequest.connectTimeout,
    sendTimeout: ConfigurationRequest.sendTimeout,
    baseUrl: ConfigurationRequest.traktSandboxUrl,
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
    baseUrl: ConfigurationRequest.tMDBUrl,
  );
  final dio = Dio(options);
  dio.interceptors.add(interceptor);
  return dio;
}
