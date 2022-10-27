import 'package:domain/base/mappers/delete_movie_mapper.dart';
import 'package:domain/base/mappers/get_date_load_mapper.dart';
import 'package:domain/base/mappers/mapper_image_url.dart';
import 'package:domain/base/mappers/movie_list_mapper.dart';
import 'package:domain/base/mappers/update_movie_mapper.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/repository/database_repository.dart';
import 'package:domain/repository/network_tmdb_repository.dart';
import 'package:domain/repository/network_trakt_repository.dart';
import 'package:domain/repository/preferences_local_repository.dart';
import 'package:domain/services/analytics_service.dart';
import 'package:domain/use_case/auth_use_case.dart';
import 'package:domain/use_case/log_analytics_button_use_case.dart';
import 'package:domain/use_case/log_analytics_page_use_case.dart';
import 'package:domain/use_case/login_facebook_use_case.dart';
import 'package:domain/use_case/login_google_use_case.dart';
import 'package:domain/use_case/login_validator_use_case.dart';
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
      GetIt.instance.get<DatabaseRepository>(),
      GetIt.instance.get<GetLoadDateMapper>(),
      GetIt.instance.get<UpdateMovieMapper>(),
      GetIt.instance.get<DeleteMovieMapper>(),
      GetIt.instance.get<MovieListMapper>(),
    ),
  );
  GetIt.instance.registerFactory<RequestDetailsUseCase>(
    () => RequestDetailsUseCase(
      GetIt.instance.get<NetworkTraktRepository>(),
      GetIt.instance.get<NetworkTMDBRepository>(),
      GetIt.instance.get<DatabaseRepository>(),
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
  GetIt.instance.registerFactory<LogAnalyticsButtonUseCase>(
    () => LogAnalyticsButtonUseCase(
      GetIt.instance.get<AnalyticsService>(),
    ),
  );
  GetIt.instance.registerFactory<LogAnalyticsPageUseCase>(
    () => LogAnalyticsPageUseCase(
      GetIt.instance.get<AnalyticsService>(),
    ),
  );
  GetIt.instance.registerFactory<LogValidatorUseCase>(
    () => LogValidatorUseCase(),
  );
}

void _initModuleMappers() {
  GetIt.instance.registerFactory<MapperImageUrl>(
    () => MapperImageUrl(),
  );
  GetIt.instance.registerFactory<GetLoadDateMapper>(
    () => GetLoadDateMapper(),
  );
  GetIt.instance.registerFactory<UpdateMovieMapper>(
    () => UpdateMovieMapper(),
  );
  GetIt.instance.registerFactory<DeleteMovieMapper>(
    () => DeleteMovieMapper(),
  );
}
