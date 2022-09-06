import 'package:domain/use_case/splash_duration_use_case.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initInjectorDomain() {
  initModuleUseCase();
}

void initModuleUseCase() {
  GetIt.instance.registerFactory(
    () => SplashDurationUseCase(),
  );
}
