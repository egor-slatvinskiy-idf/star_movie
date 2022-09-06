import 'package:domain/di/injector_domain.dart';
import 'package:data/di/injector_data.dart';
import 'package:presentation/di/injector_presentation.dart';

Future<void> appInjector() async {
  initInjectorPresentation();
  initInjectorDomain();
  initInjectorData();
}
