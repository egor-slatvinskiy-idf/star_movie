import 'package:data/di/injector_data.dart';
import 'package:domain/di/injector_domain.dart';
import 'package:presentation/di/injector_presentation.dart';

Future<void> appInjector() async {
  await initInjectorData();
  await initInjectorDomain();
  initInjectorPresentation();
}
