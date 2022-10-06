import 'package:domain/base/mappers/mapper_image_url.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/repository/network_tmdb_repository.dart';
import 'package:domain/repository/network_trakt_repository.dart';
import 'package:domain/repository/preferences_local_repository.dart';
import 'package:domain/services/analytics_service.dart';
import 'package:domain/use_case/analytics_use_case.dart';
import 'package:domain/use_case/auth_use_case.dart';
import 'package:domain/use_case/login_facebook_use_case.dart';
import 'package:domain/use_case/login_google_use_case.dart';
import 'package:domain/use_case/request_details_use_case.dart';
import 'package:domain/use_case/request_movie_list_use_case.dart';
import 'package:domain/use_case/splash_duration_use_case.dart';
import 'package:get_it/get_it.dart';

void initInjectorDomain() {
  _initModuleMappers();
  _initModuleUseCase();
}

void _initModuleUseCase() {
  GetIt.instance.registerFactory(
    () => SplashDurationUseCase(),
  );
  GetIt.instance.registerFactory<RequestMovieListUseCase>(
    () => RequestMovieListUseCase(
      GetIt.instance.get<NetworkTraktRepository>(),
    ),
  );
  GetIt.instance.registerFactory<RequestDetailsUseCase>(
    () => RequestDetailsUseCase(
      GetIt.instance.get<NetworkTraktRepository>(),
      GetIt.instance.get<NetworkTMDBRepository>(),
    ),
  );
  GetIt.instance.registerFactory<LoginEmailAndPassUseCase>(
    () => LoginEmailAndPassUseCase(
      GetIt.instance.get<AuthRepository>(),
      GetIt.instance.get<PreferencesLocalRepository>(),
    ),
  );
  GetIt.instance.registerFactory<LoginFacebookUseCase>(
    () => LoginFacebookUseCase(
      GetIt.instance.get<AuthRepository>(),
      GetIt.instance.get<PreferencesLocalRepository>(),
    ),
  );
  GetIt.instance.registerFactory<LoginGoogleUseCase>(
    () => LoginGoogleUseCase(
      GetIt.instance.get<AuthRepository>(),
      GetIt.instance.get<PreferencesLocalRepository>(),
    ),
  );
  GetIt.instance.registerFactory<AnalyticsUseCase>(
    () => AnalyticsUseCase(
      GetIt.instance.get<AnalyticsService>(),
    ),
  );
}

void _initModuleMappers() {
  GetIt.instance.registerFactory<MapperImageUrl>(
    () => MapperImageUrl(),
  );
}
