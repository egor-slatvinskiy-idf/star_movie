import 'package:domain/repository/network_repository.dart';
import 'package:domain/use_case/request_use_case_coming.dart';
import 'package:domain/use_case/request_use_case_trending.dart';
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
  GetIt.instance.registerFactory<RequestUseCaseTrending>(
    () => RequestUseCaseTrending(
      GetIt.instance.get<NetworkRepository>(),
    ),
  );
  GetIt.instance.registerFactory<RequestUseCaseComing>(
    () => RequestUseCaseComing(
      GetIt.instance.get<NetworkRepository>(),
    ),
  );
}
