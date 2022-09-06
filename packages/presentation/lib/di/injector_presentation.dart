import 'package:domain/use_case/splash_duration_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/navigation/app_navigator.dart';
import 'package:presentation/ui/splash_screen/bloc/splash_bloc.dart';

void initInjectorPresentation() {
  _initModuleBloc();
  _initModuleApp();
}

void _initModuleBloc() {
  GetIt.instance.registerFactory<SplashBloc>(
    () => SplashBloc(
      SplashDurationUseCase(),
    ),
  );
}

void _initModuleApp() {
  GetIt.instance.registerFactory<AppBloc>(
    () => AppBloc(),
  );
  GetIt.instance.registerSingleton<AppNavigator>(
    AppNavigator(),
  );
}
