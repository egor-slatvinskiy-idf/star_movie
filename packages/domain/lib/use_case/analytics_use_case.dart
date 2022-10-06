import 'package:domain/services/analytics_service.dart';
import 'package:domain/use_case/sample_use_case/use_case_in_out.dart';

class AnalyticsUseCase extends UseCaseInOut<String, Future<void>> {
  final AnalyticsService analytics;

  AnalyticsUseCase(this.analytics);

  @override
  Future<void> call(String params) => analytics.analyticsClick(params);
}
