import 'package:domain/base/mappers/mapper_image_url.dart';
import 'package:domain/repository/network_tmdb_repository.dart';
import 'package:domain/repository/network_trakt_repository.dart';
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
}

void _initModuleMappers() {
  GetIt.instance.registerFactory<MapperImageUrl>(
    () => MapperImageUrl(),
  );
}
