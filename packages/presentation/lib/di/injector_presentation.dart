import 'package:domain/base/mappers/mapper_image_url.dart';
import 'package:domain/use_case/analytics_use_case.dart';
import 'package:domain/use_case/auth_use_case.dart';
import 'package:domain/use_case/login_facebook_use_case.dart';
import 'package:domain/use_case/login_google_use_case.dart';
import 'package:domain/use_case/request_details_use_case.dart';
import 'package:domain/use_case/request_movie_list_use_case.dart';
import 'package:domain/use_case/splash_duration_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/navigation/app_navigator.dart';
import 'package:presentation/ui/auth_page/bloc/auth_bloc.dart';
import 'package:presentation/ui/movie_details/bloc/movie_details_bloc.dart';
import 'package:presentation/ui/movie_page/bloc/movie_bloc.dart';
import 'package:presentation/ui/movie_page/mapper/mapper_movie_list.dart';
import 'package:presentation/ui/profile_page/bloc/profile_bloc.dart';
import 'package:presentation/ui/splash_screen/bloc/splash_bloc.dart';

void initInjectorPresentation() {
  _initModuleMappers();
  _initModuleBloc();
  _initModuleApp();
}

void _initModuleBloc() {
  GetIt.instance.registerFactory<SplashBloc>(
    () => SplashBloc(
      SplashDurationUseCase(),
    ),
  );
  GetIt.instance.registerFactory<MovieBloc>(
    () => MovieBloc(
      GetIt.instance.get<RequestMovieListUseCase>(),
      GetIt.instance.get<MapperMovieList>(),
      GetIt.instance.get<AnalyticsUseCase>(),
    ),
  );
  GetIt.instance.registerFactory<MovieDetailsBloc>(
    () => MovieDetailsBloc(
      GetIt.instance.get<RequestDetailsUseCase>(),
      GetIt.instance.get<AnalyticsUseCase>(),
    ),
  );
  GetIt.instance.registerFactory<AuthBloc>(
    () => AuthBloc(
      GetIt.instance.get<LoginEmailAndPassUseCase>(),
      GetIt.instance.get<LoginGoogleUseCase>(),
      GetIt.instance.get<LoginFacebookUseCase>(),
      GetIt.instance.get<AnalyticsUseCase>(),
    ),
  );
  GetIt.instance.registerFactory<ProfileBloc>(
    () => ProfileBloc(),
  );
}

void _initModuleApp() {
  GetIt.instance.registerFactory<AppBloc>(
    () => AppBloc(
      GetIt.instance.get<AnalyticsUseCase>(),
    ),
  );
  GetIt.instance.registerSingleton<AppNavigator>(
    AppNavigator(),
  );
}

void _initModuleMappers() {
  GetIt.instance.registerFactory<MapperMovieList>(
    () => MapperMovieList(
      mapperImageUrl: GetIt.instance.get<MapperImageUrl>(),
    ),
  );
}
