import 'package:domain/services/analytics_service.dart';
import 'package:domain/use_case/sample_use_case/use_case_in.dart';

class AnalyticsButtonUseCase extends UseCaseIn<String> {
  final AnalyticsService analytics;

  AnalyticsButtonUseCase(this.analytics);

  @override
  Future<void> call(String params) => analytics.analyticsEvent(params);
}
