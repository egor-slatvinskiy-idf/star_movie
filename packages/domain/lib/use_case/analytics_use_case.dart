import 'package:domain/model/firebase_analytics_model.dart';
import 'package:domain/services/analytics_service.dart';
import 'package:domain/use_case/sample_use_case/use_case_in_out.dart';

class AnalyticsUseCase
    extends UseCaseInOut<FirebaseAnalyticsModel, Future<void>> {
  final AnalyticsService analytics;

  AnalyticsUseCase(this.analytics);

  @override
  Future<void> call(FirebaseAnalyticsModel params) => analytics.analyticsEvent(
        eventName: params.eventName,
        payload: params.eventScreenLog,
      );
}
