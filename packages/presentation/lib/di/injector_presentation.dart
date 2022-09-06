import 'package:get_it/get_it.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/navigation/app_navigator.dart';

void initInjectorPresentation() {
  _initModuleApp();
}

void _initModuleApp() {
  GetIt.instance.registerFactory<AppBloc>(
    () => AppBloc(),
  );
  GetIt.instance.registerSingleton<AppNavigator>(
    AppNavigator(),
  );
}
